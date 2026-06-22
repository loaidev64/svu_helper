import 'dart:convert';
import 'dart:io';

const _coursesPath = 'assets/courses';

void main() {
  final root = Directory(_coursesPath);
  if (!root.existsSync()) {
    stderr.writeln('ERROR: $_coursesPath not found');
    exit(1);
  }

  final courses =
      root.listSync().whereType<Directory>().toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  int quizConverted = 0;
  int flashcardConverted = 0;
  int quizFixed = 0;

  for (final courseDir in courses) {
    final code = courseDir.path.split(separator).last;
    if (code.startsWith('.')) continue;

    final manifestPath = '${courseDir.path}${separator}manifest.json';
    if (!File(manifestPath).existsSync()) {
      print('  [$code] no manifest.json — skipping');
      continue;
    }

    final manifest = jsonDecode(File(manifestPath).readAsStringSync())
        as Map<String, dynamic>;
    final units = manifest['units'] as List<dynamic>;
    bool manifestDirty = false;

    // ── Quizzes ──
    for (final unit in units) {
      final quizFile = unit['quiz'] as String;
      if (quizFile.endsWith('.md')) {
        final quizPath = '${courseDir.path}${separator}$quizFile';
        if (!File(quizPath).existsSync()) continue;

        print('  [$code] quiz: $quizFile → json');
        final json = _parseQuiz(File(quizPath).readAsStringSync());

        final jsonFile = quizFile.replaceAll('.md', '.json');
        File('${courseDir.path}${separator}$jsonFile')
            .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(json));
        File(quizPath).deleteSync();
        unit['quiz'] = jsonFile;
        manifestDirty = true;
        quizConverted++;
      } else if (quizFile.endsWith('.json')) {
        // Fix existing quiz JSONs: IDs, hints (page/section)
        final quizPath = '${courseDir.path}${separator}$quizFile';
        if (!File(quizPath).existsSync()) continue;
        final data =
            jsonDecode(File(quizPath).readAsStringSync()) as Map<String, dynamic>;
        final questions = data['questions'] as List<dynamic>;
        bool needsFix = false;

        for (int i = 0; i < questions.length; i++) {
          final q = questions[i] as Map<String, dynamic>;
          // Fix IDs
          final expectedId = i + 1;
          if (q['id'] != expectedId) {
            needsFix = true;
            q['id'] = expectedId;
          }
          // Parse/re-parse hint for page & section
          final hint = q['hint'] as String? ?? '';
          if (hint.isNotEmpty) {
            final parsed = _parseHint(hint);
            if (parsed != null) {
              final oldPage = q['page'];
              final oldSection = q['section'];
              if (oldPage != parsed['page'] || oldSection != parsed['section']) {
                needsFix = true;
                q['page'] = parsed['page'];
                q['section'] = parsed['section'];
                q['hint'] = parsed['hint'];
              }
            }
          }
        }

        if (needsFix) {
          File(quizPath).writeAsStringSync(
              const JsonEncoder.withIndent('  ').convert(data));
          quizFixed++;
          print('  [$code] quiz: $quizFile fixed');
        }
      }
    }

    // ── Flashcards ──
    for (final unit in units) {
      final fcFile = unit['flashcards'] as String;
      if (!fcFile.endsWith('.md')) continue;

      final fcPath = '${courseDir.path}${separator}$fcFile';
      if (!File(fcPath).existsSync()) continue;

      print('  [$code] flashcards: $fcFile → json');
      final json = _parseFlashcards(File(fcPath).readAsStringSync());

      final jsonFile = fcFile.replaceAll('.md', '.json');
      File('${courseDir.path}${separator}$jsonFile')
          .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(json));
      File(fcPath).deleteSync();
      unit['flashcards'] = jsonFile;
      manifestDirty = true;
      flashcardConverted++;
    }

    if (manifestDirty) {
      File(manifestPath).writeAsStringSync(
          const JsonEncoder.withIndent('  ').convert(manifest));
      print('  [$code] manifest updated');
    }
  }

  final parts = <String>[];
  if (quizConverted > 0) parts.add('$quizConverted quizzes converted');
  if (quizFixed > 0) parts.add('$quizFixed quizzes fixed');
  if (flashcardConverted > 0) parts.add('$flashcardConverted flashcards converted');
  print('\n  Done! ${parts.join(', ')}.');
}

// ── helpers ──────────────────────────────────────────────────────────

String get separator => Platform.pathSeparator;

/// Parse quiz markdown → { title, questions[] }
Map<String, dynamic> _parseQuiz(String content) {
  String title = '';
  final questions = <Map<String, dynamic>>[];

  final parts = content.split(RegExp(r'^## Question \d+\s*$', multiLine: true));

  for (int i = 0; i < parts.length; i++) {
    String block = parts[i].trim();
    if (block.isEmpty) continue;

    if (i == 0) {
      // First block: optional title heading
      for (final line in LineSplitter.split(block)) {
        final t = line.trim();
        if (t.startsWith('# ') && !t.startsWith('## ')) {
          title = t.substring(2).trim();
          break;
        }
      }
      // Also check if first block contains questions embedded (INT203 style)
      // INT203 starts directly with ## Question 1, so the first part after
      // splitting by ## Question would be empty, and part 1 is Q1
      if (title.isNotEmpty || block.startsWith('#')) {
        continue;
      }
    }

    // Parse a single question block
    final q = _parseQuestionBlock(block);
    if (q != null) {
      q['id'] = questions.length + 1;
      questions.add(q);
    }
  }

  // If the first block had no title but is a question (edge case where
  // content has no ## Question split match), handle it
  if (questions.isEmpty && parts.length == 1 && parts[0].trim().isNotEmpty) {
    final q = _parseQuestionBlock(parts[0].trim());
    if (q != null) {
      q['id'] = 1;
      questions.add(q);
    }
  }

  return {'title': title, 'questions': questions};
}

Map<String, dynamic>? _parseQuestionBlock(String block) {
  final lines = LineSplitter.split(block).toList();

  // Find where options start
  int optStart = -1;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trimLeft().startsWith('- [')) {
      optStart = i;
      break;
    }
  }
  if (optStart == -1) return null;

  // Question text: everything before options
  final questionLines = lines.sublist(0, optStart);
  // Remove any leading blank lines
  while (questionLines.isNotEmpty && questionLines.first.trim().isEmpty) {
    questionLines.removeAt(0);
  }
  final question = questionLines.map((l) => l.trim()).join(' ').trim();

  // Options
  final options = <String>[];
  int correctIndex = -1;

  int optEnd = optStart;
  while (optEnd < lines.length && lines[optEnd].trimLeft().startsWith('- [')) {
    final line = lines[optEnd].trimLeft();
    final isCorrect = line.startsWith('- [x]');
    final text = line.replaceFirst(RegExp(r'^- \[.\]\s*'), '').trim();
    options.add(text);
    if (isCorrect) correctIndex = optEnd - optStart;
    optEnd++;
  }

  // Hint & Explanation
  String hint = '';
  String explanation = '';
  bool inExplanation = false;

  for (int i = optEnd; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trim();

    if (trimmed.startsWith('**Hint:**')) {
      hint = trimmed.substring('**Hint:**'.length).trim();
      inExplanation = false;
    } else if (trimmed.startsWith('**Explanation:**')) {
      explanation = trimmed.substring('**Explanation:**'.length).trim();
      inExplanation = true;
    } else if (inExplanation) {
      if (explanation.isNotEmpty) explanation += '\n';
      explanation += line;
    } else if (trimmed.isEmpty) {
      inExplanation = false;
    }
  }

  explanation = explanation.trim();

  // Parse hint to extract page & section, then rewrite hint in Arabic
  final parsed = _parseHint(hint);
  if (parsed != null) {
    hint = parsed['hint'] as String;
  }

  return {
    'question': question,
    'options': options,
    'correctIndex': correctIndex,
    'page': parsed?['page'],
    'section': parsed?['section'],
    'hint': hint,
    'explanation': explanation,
  };
}

/// Parse hint text to extract page & section, then rewrite in Arabic.
///
/// Returns `{page, section, hint}` or `null` if the hint can't be parsed.
Map<String, dynamic>? _parseHint(String hint) {
  // 1) New format: (page N, section "xxx") or (page N) or (page N-M, ...)
  final newMatch = RegExp(
    r'\(page\s+(\d+(?:-\d+)?)(?:,\s*section\s+"([^"]*)")?\)',
  ).firstMatch(hint);

  if (newMatch != null) {
    final page = newMatch.group(1)!;
    final section = newMatch.group(2);
    final rewritten = section != null && section.isNotEmpty
        ? 'راجع الصفحة $page في الفقرة $section'
        : 'راجع الصفحة $page';
    return {'page': page, 'section': section, 'hint': rewritten};
  }

  // 2) Fallback: old Arabic format
  //    "...الصفحة {N}، القسم {section}" or "الصفحة {N}"
  //    section is everything after القسم/الفصل up to a period or end
  //    First try with section
  final oldMatch = RegExp(
    "الصفحة\\s+(\\d+(?:-\\d+)?)[،,]\\s*(?:القسم|الفصل)\\s+[\"']?(.+?)[\"']?\\.",
  ).firstMatch(hint);

  if (oldMatch != null) {
    final page = oldMatch.group(1)!;
    String? section = oldMatch.group(2)?.trim();
    // Clean trailing punctuation from section
    if (section != null) section = section.replaceAll(RegExp(r'[.\)\]]+$'), '').trim();
    final rewritten = section != null && section.isNotEmpty
        ? 'راجع الصفحة $page في الفقرة $section'
        : 'راجع الصفحة $page';
    return {'page': page, 'section': section, 'hint': rewritten};
  }

  // 3) Already-rewritten format: "راجع الصفحة {N} في الفقرة {section}" or "راجع الصفحة {N}"
  //    (check before page-only, since page-only matches inside rewritten text)
  final rewrittenMatch = RegExp(
    "راجع الصفحة\\s+(\\d+(?:-\\d+)?)(?:\\s+في الفقرة\\s+(.+))?",
  ).firstMatch(hint);

  if (rewrittenMatch != null) {
    final page = rewrittenMatch.group(1)!;
    String? section = rewrittenMatch.group(2)?.trim();
    if (section != null && section.isEmpty) section = null;
    final rewritten = section != null
        ? 'راجع الصفحة $page في الفقرة $section'
        : 'راجع الصفحة $page';
    return {'page': page, 'section': section, 'hint': rewritten};
  }

  // 4) Old format page-only: "الصفحة {N}" or similar (last resort)
  final pageOnlyMatch = RegExp("الصفحة\\s+(\\d+(?:-\\d+)?)").firstMatch(hint);

  if (pageOnlyMatch != null) {
    final page = pageOnlyMatch.group(1)!;
    return {'page': page, 'section': null, 'hint': 'راجع الصفحة $page'};
  }

  return null;
}

/// Parse flashcard markdown → { title, cards[] }
Map<String, dynamic> _parseFlashcards(String content) {
  String title = '';
  final cards = <Map<String, dynamic>>[];

  final parts = content.split(RegExp(r'^## Card \d+\s*$', multiLine: true));

  for (int i = 0; i < parts.length; i++) {
    String block = parts[i].trim();
    if (block.isEmpty) continue;

    if (i == 0) {
      // Title from first `# ` line
      for (final line in LineSplitter.split(block)) {
        final t = line.trim();
        if (t.startsWith('# ') && !t.startsWith('## ')) {
          title = t.substring(2).trim();
          break;
        }
      }
      continue;
    }

    // Remove separator --- and its surrounding whitespace
    block = block.replaceAll(RegExp(r'^-{3,}\s*', multiLine: true), '').trim();

    String q = '';
    String a = '';

    // Extract **Q:** and **A:**
    final qMatch = RegExp(r'\*\*Q:\*\*(.*?)(?=\*\*A:\*\*|\Z)', dotAll: true)
        .firstMatch(block);
    final aMatch = RegExp(r'\*\*A:\*\*(.*)', dotAll: true).firstMatch(block);

    if (qMatch != null) {
      q = qMatch.group(1)!.trim();
      // Remove trailing (page ref) from Q if present on same line as A
    }
    if (aMatch != null) {
      a = aMatch.group(1)!.trim();
    }

    // If the Q has a standalone page reference at the end, keep it (it's part of the content)
    if (q.isNotEmpty || a.isNotEmpty) {
      cards.add({'id': cards.length + 1, 'q': q, 'a': a});
    }
  }

  return {'title': title, 'cards': cards};
}
