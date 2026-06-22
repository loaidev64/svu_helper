import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flashcard_screen.dart';
import 'pdf_screen.dart';
import 'quiz_screen.dart';

class CourseScreen extends StatefulWidget {
  final String courseCode;
  const CourseScreen({super.key, required this.courseCode});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  Map<String, dynamic>? _manifest;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadManifest();
  }

  Future<void> _loadManifest() async {
    final raw = await rootBundle.loadString(
      'assets/courses/${widget.courseCode}/manifest.json',
    );
    setState(() {
      _manifest = jsonDecode(raw) as Map<String, dynamic>;
      _loading = false;
    });
  }

  void _showUnitOptions(Map<String, dynamic> unit) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  unit['title'] as String,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('PDF'),
                subtitle: const Text('عرض الملف الأصلي'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PdfScreen(
                        courseCode: widget.courseCode,
                        unitId: unit['id'] as String,
                        filePath:
                            'assets/courses/${widget.courseCode}/${unit['pdf']}',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.quiz_outlined),
                title: const Text('Quiz'),
                subtitle: Text('${unit['quizCount']} سؤال'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(
                        courseCode: widget.courseCode,
                        unitId: unit['id'] as String,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.style_outlined),
                title: const Text('Flashcards'),
                subtitle: Text('${unit['flashcardCount']} بطاقة'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FlashcardScreen(
                        courseCode: widget.courseCode,
                        unitId: unit['id'] as String,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_manifest != null
            ? (_manifest!['title'] as String)
            : widget.courseCode),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: (_manifest!['units'] as List).length,
              itemBuilder: (context, i) {
                final u = (_manifest!['units'] as List)[i]
                    as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(u['id'] as String),
                    ),
                    title: Text(u['title'] as String),
                    subtitle: Text(
                      '${u['quizCount']} سؤال · ${u['flashcardCount']} بطاقة',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showUnitOptions(u),
                  ),
                );
              },
            ),
    );
  }
}
