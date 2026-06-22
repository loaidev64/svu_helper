import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flip_card/flip_card.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class FlashcardScreen extends StatefulWidget {
  final String courseCode;
  final String unitId;

  const FlashcardScreen({
    super.key,
    required this.courseCode,
    required this.unitId,
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<Map<String, dynamic>> _cards = [];
  bool _loading = true;
  String? _error;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    try {
      final path =
          'assets/courses/${widget.courseCode}/${widget.courseCode}_${widget.unitId}_flashcards.json';
      final raw = await rootBundle.loadString(path);
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final cards =
          (data['cards'] as List<dynamic>).cast<Map<String, dynamic>>();
      cards.shuffle(Random());
      setState(() {
        _cards = cards;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _nextCard() {
    if (_currentIndex < _cards.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _prevCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseCode} - Flashcards'),
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
    if (_cards.isEmpty) {
      return const Center(child: Text('لا توجد بطاقات'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('بطاقة ${_currentIndex + 1} من ${_cards.length}'),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (_currentIndex + 1) / _cards.length,
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: FlipCard(
              key: ValueKey(_currentIndex),
              front: _buildCardSide(
                text: _cards[_currentIndex]['q'] as String,
                color: Colors.amber.shade50,
                hint: 'اضغط للإجابة',
              ),
              back: _buildCardSide(
                text: _cards[_currentIndex]['a'] as String,
                color: Colors.indigo.shade50,
                hint: 'اضغط للسؤال',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentIndex > 0)
                OutlinedButton.icon(
                  onPressed: _prevCard,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('السابق'),
                )
              else
                const SizedBox.shrink(),
              if (_currentIndex < _cards.length - 1)
                OutlinedButton.icon(
                  onPressed: _nextCard,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('التالي'),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardSide({
    required String text,
    required Color color,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                hint,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: 24),
              Flexible(
                child: SingleChildScrollView(
                  child: GptMarkdown(
                    text,
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
    );
  }
}
