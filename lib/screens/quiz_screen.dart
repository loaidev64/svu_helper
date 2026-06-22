import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import '../services/course_service.dart';
import 'pdf_screen.dart';

class QuizScreen extends StatefulWidget {
  final String courseCode;
  final String unitId;
  final bool isDownloaded;

  const QuizScreen({
    super.key,
    required this.courseCode,
    required this.unitId,
    this.isDownloaded = false,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _AnswerRecord {
  final String question;
  final String selectedAnswer;
  final String correctAnswer;
  final String explanation;
  final bool isCorrect;

  const _AnswerRecord({
    required this.question,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.explanation,
    required this.isCorrect,
  });
}

enum _ScreenMode { quiz, result, review }

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> _questions = [];
  bool _loading = true;
  String? _error;
  int _currentIndex = 0;
  int? _selectedOption;
  bool _answered = false;
  List<_AnswerRecord> _answers = [];
  _ScreenMode _mode = _ScreenMode.quiz;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    try {
      final fileName =
          '${widget.courseCode}_${widget.unitId}_quiz.json';
      final raw = await CourseService.readCourseFile(widget.courseCode, fileName);
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final questions = (data['questions'] as List<dynamic>)
          .cast<Map<String, dynamic>>();

      final rng = Random();
      questions.shuffle(rng);

      for (final q in questions) {
        final opts = (q['options'] as List<dynamic>).cast<String>();
        final correctIdx = q['correctIndex'] as int;

        final indices = List.generate(opts.length, (i) => i);
        indices.shuffle(rng);

        q['options'] = indices.map((i) => opts[i]).toList();
        q['correctIndex'] = indices.indexOf(correctIdx);
      }

      setState(() {
        _questions = questions;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
    });
  }

  void _submitAnswer() {
    final q = _questions[_currentIndex];
    final selectedText = q['options'][_selectedOption!] as String;
    final correctIdx = q['correctIndex'] as int;
    final correctText = q['options'][correctIdx] as String;
    final isCorrect = _selectedOption == correctIdx;

    _answers.add(
      _AnswerRecord(
        question: q['question'] as String,
        selectedAnswer: selectedText,
        correctAnswer: correctText,
        explanation: q['explanation'] as String? ?? '',
        isCorrect: isCorrect,
      ),
    );

    if (_currentIndex + 1 >= _questions.length) {
      setState(() {
        _mode = _ScreenMode.result;
      });
    } else {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
    }
  }

  void _reviewWrongAnswers() {
    setState(() {
      _mode = _ScreenMode.review;
    });
  }

  void _restartQuiz() {
    _currentIndex = 0;
    _selectedOption = null;
    _answered = false;
    _answers = [];
    _mode = _ScreenMode.quiz;
    _loadQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseCode} - Quiz'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }
    switch (_mode) {
      case _ScreenMode.quiz:
        return _buildQuizView();
      case _ScreenMode.result:
        return _buildResultView();
      case _ScreenMode.review:
        return _buildReviewView();
    }
  }

  Widget _buildQuizView() {
    final q = _questions[_currentIndex];
    final opts = (q['options'] as List<dynamic>).cast<String>();
    final correctIdx = q['correctIndex'] as int;

    return Column(
      children: [
        LinearProgressIndicator(value: (_currentIndex + 1) / _questions.length),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('السؤال ${_currentIndex + 1} من ${_questions.length}'),
              Text(
                '${((_currentIndex + 1) / _questions.length * 100).toInt()}%',
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (q['page'] != null)
                        Tooltip(
                          message:
                              q['hint'] as String? ??
                              'راجع الصفحة ${q['page']}',
                          child: IconButton(
                            icon: Icon(
                              Icons.help_outline,
                              color: Colors.amber.shade700,
                            ),
                            onPressed: () async {
                              final fileName =
                                  '${widget.courseCode}_${widget.unitId}_pdf.pdf';
                              final dir = await CourseService.getCourseDir(widget.courseCode);
                              final path = '$dir/$fileName';
                              if (!mounted) return;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PdfScreen(
                                    courseCode: widget.courseCode,
                                    unitId: widget.unitId,
                                    filePath: path,
                                    initialPage: (int.tryParse(
                                          q['page'] as String? ?? '',
                                        ) ??
                                        0) +
                                        1,
                                    isDownloaded: widget.isDownloaded,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GptMarkdown(
                            q['question'] as String,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            useDollarSignsForLatex: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(opts.length, (i) {
                Color? bgColor;
                Color? txtColor;
                if (_answered) {
                  if (i == correctIdx) {
                    bgColor = Colors.green.shade100;
                    txtColor = Colors.green.shade800;
                  } else if (i == _selectedOption && i != correctIdx) {
                    bgColor = Colors.red.shade100;
                    txtColor = Colors.red.shade800;
                  }
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: _selectedOption == i
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      title: GptMarkdown(
                        opts[i],
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        useDollarSignsForLatex: true,
                        style: txtColor != null
                            ? TextStyle(color: txtColor)
                            : null,
                      ),
                      trailing: _answered
                          ? (i == correctIdx
                                ? Icon(Icons.check_circle, color: Colors.green)
                                : (i == _selectedOption
                                      ? Icon(Icons.cancel, color: Colors.red)
                                      : null))
                          : null,
                      onTap: () => _selectOption(i),
                    ),
                  ),
                );
              }),
              if (_answered) ...[
                const SizedBox(height: 8),
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: Colors.blue.shade700,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'شرح',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GptMarkdown(
                          q['explanation'] as String? ?? '',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          useDollarSignsForLatex: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _submitAnswer,
                    icon: Icon(
                      _currentIndex + 1 >= _questions.length
                          ? Icons.flag
                          : Icons.arrow_forward,
                    ),
                    label: Text(
                      _currentIndex + 1 >= _questions.length
                          ? 'عرض النتيجة'
                          : 'التالي',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    final total = _answers.length;
    final correct = _answers.where((a) => a.isCorrect).length;
    final wrong = total - correct;
    final percentage = total > 0 ? (correct / total) * 100 : 0.0;

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: percentage / 100,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade200,
                    color: percentage >= 70 ? Colors.green : Colors.orange,
                  ),
                  Text(
                    '${percentage.toInt()}%',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'النتيجة',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatCard('صحيح', correct, Colors.green),
              const SizedBox(width: 16),
              _buildStatCard('خطأ', wrong, Colors.red),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'من أصل $total أسئلة',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          if (wrong > 0)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _reviewWrongAnswers,
                icon: const Icon(Icons.replay),
                label: const Text('مراجعة الإجابات الخاطئة'),
              ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _restartQuiz,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة الاختبار'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count, MaterialColor color) {
    return Card(
      color: color.shade50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color.shade700,
              ),
            ),
            Text(label, style: TextStyle(color: color.shade700)),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewView() {
    final wrong = _answers.where((a) => !a.isCorrect).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wrong.length,
      itemBuilder: (context, i) {
        final a = wrong[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'السؤال ${i + 1}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Colors.red.shade700),
                ),
                const SizedBox(height: 8),
                GptMarkdown(
                  a.question,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  useDollarSignsForLatex: true,
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(Icons.close, size: 18, color: Colors.red),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'إجابتك: ',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          GptMarkdown(
                            a.selectedAnswer,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            useDollarSignsForLatex: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(Icons.check, size: 18, color: Colors.green),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الإجابة الصحيحة: ',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          GptMarkdown(
                            a.correctAnswer,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            useDollarSignsForLatex: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (a.explanation.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GptMarkdown(
                      a.explanation,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      useDollarSignsForLatex: true,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
