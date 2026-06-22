import 'dart:convert';
import 'dart:io';

const _coursesPath = 'assets/courses';

void main() {
  final root = Directory(_coursesPath);
  if (!root.existsSync()) {
    stderr.writeln('ERROR: $_coursesPath not found');
    exit(1);
  }

  final courses = <Map<String, dynamic>>[];
  bool anyWorkDone = false;

  for (final courseDir in root.listSync().whereType<Directory>().toList()
    ..sort((a, b) => a.path.compareTo(b.path))) {
    final code = courseDir.path.split(separator).last;
    if (code.startsWith('.')) continue;

    print('  [$code] processing...');

    final coursePath = courseDir.path;
    final manifestFile = File('$coursePath${separator}manifest.json');
    final hasManifest = manifestFile.existsSync();

    // Support both: chapters/XXX (new) and XXX/ (old nested)
    String contentBase = coursePath;
    final chaptersDir = Directory('$coursePath${separator}chapters');
    if (chaptersDir.existsSync()) {
      contentBase = chaptersDir.path;
    }

    final unitDirs = Directory(contentBase).listSync().whereType<Directory>().toList()
      ..sort((a, b) => a.path.compareTo(b.path));
    final unitIds = unitDirs
        .map((d) => d.path.split(separator).last)
        .where((n) => RegExp(r'^\d{3}$').hasMatch(n))
        .toList();

    // If no nested unit dirs exist, try reading flat files directly
    if (unitIds.isEmpty) {
      // Check if flat files already exist
      final flatFiles = courseDir.listSync().whereType<File>().toList();
      final unitIdsFromFiles = flatFiles
          .map((f) {
            final name = f.path.split(separator).last;
            final m = RegExp('^${code}_(\\d{3})_').firstMatch(name);
            return m?.group(1);
          })
          .whereType<String>()
          .toSet()
          .toList()
        ..sort();

      if (unitIdsFromFiles.isEmpty) {
        print('    no units found');
        continue;
      }

      if (hasManifest) {
        print('    already processed — skipping');
        final existing = jsonDecode(manifestFile.readAsStringSync());
        courses.add({
          'code': code,
          'title': existing['title'],
          'totalUnits': existing['totalUnits'],
        });
        continue;
      }

      print('    found ${unitIdsFromFiles.length} flat units, building manifest...');

      final courseTitle = _deriveCourseTitleFromFlat(code, coursePath,
          unitIdsFromFiles.first);
      final units = <Map<String, dynamic>>[];

      for (final unitId in unitIdsFromFiles) {
        final prefix = '${code}_$unitId';
        final lectureContent = _readFileMaybe(
            '$coursePath${separator}${prefix}_lecture.md');
        final quizContent =
            _readFileMaybe('$coursePath${separator}${prefix}_quiz.md');
        final flashcardContent =
            _readFileMaybe('$coursePath${separator}${prefix}_flashcards.md');

        final title = _extractTitle(
          lectureContent: lectureContent,
          quizContent: quizContent,
          flashcardContent: flashcardContent,
          unitId: unitId,
        );

        final quizCount = _countMatches(
            quizContent, RegExp(r'^## Question \d+', multiLine: true));
        final flashcardCount = _countMatches(
            flashcardContent, RegExp(r'^## Card \d+', multiLine: true));

        units.add({
          'id': unitId,
          'title': title,
          'lecture': '${prefix}_lecture.md',
          'quiz': '${prefix}_quiz.md',
          'flashcards': '${prefix}_flashcards.md',
          'pdf': '${prefix}_pdf.pdf',
          'quizCount': quizCount,
          'flashcardCount': flashcardCount,
        });
      }

      final manifest = {
        'code': code,
        'title': courseTitle ?? code,
        'totalUnits': units.length,
        'units': units,
      };
      manifestFile.writeAsStringSync(
          const JsonEncoder.withIndent('  ').convert(manifest));
      print('    wrote manifest (${units.length} units)');
      anyWorkDone = true;

      courses.add({
        'code': code,
        'title': courseTitle ?? code,
        'totalUnits': units.length,
      });
      continue;
    }

    // ── Old nested structure exists: flatten it ──
    anyWorkDone = true;
    final unitBase = contentBase; // coursePath or coursePath/chapters
    final courseTitle = _deriveCourseTitleFromNested(
        '$unitBase${separator}${unitIds.first}', code);
    final units = <Map<String, dynamic>>[];

    for (final unitId in unitIds) {
      print('    unit $unitId...');

      final unitPath = '$unitBase${separator}$unitId';
      final lectureContent = _readText('$unitPath${separator}markdowns');
      final quizContent = _readText('$unitPath${separator}quizzes');
      final flashcardContent = _readText('$unitPath${separator}flashcards');
      final pdfSource = _findFile('$unitPath${separator}pdfs', '.pdf');

      final title = _extractTitle(
        lectureContent: lectureContent,
        quizContent: quizContent,
        flashcardContent: flashcardContent,
        unitId: unitId,
      );
      final quizCount = _countMatches(
          quizContent, RegExp(r'^## Question \d+', multiLine: true));
      final flashcardCount = _countMatches(
          flashcardContent, RegExp(r'^## Card \d+', multiLine: true));

      // Write flat files
      final prefix = '${code}_$unitId';
      _writeFile('$coursePath${separator}${prefix}_lecture.md', lectureContent);
      _writeFile('$coursePath${separator}${prefix}_quiz.md', quizContent);
      _writeFile('$coursePath${separator}${prefix}_flashcards.md',
          flashcardContent);

      if (pdfSource != null) {
        final dest = File('$coursePath${separator}${prefix}_pdf.pdf');
        if (!dest.existsSync()) File(pdfSource).copySync(dest.path);
      }

      // Remove old nested dirs
      for (final sub in ['markdowns', 'quizzes', 'flashcards', 'pdfs']) {
        final d = Directory('$unitPath${separator}$sub');
        if (d.existsSync()) d.deleteSync(recursive: true);
      }
      Directory(unitPath).deleteSync();

      units.add({
        'id': unitId,
        'title': title,
        'lecture': '${prefix}_lecture.md',
        'quiz': '${prefix}_quiz.md',
        'flashcards': '${prefix}_flashcards.md',
        'pdf': '${prefix}_pdf.pdf',
        'quizCount': quizCount,
        'flashcardCount': flashcardCount,
      });
    }

    // Clean up chapters/ wrapper if it was used
    if (chaptersDir.existsSync()) chaptersDir.deleteSync();

    final manifest = {
      'code': code,
      'title': courseTitle ?? code,
      'totalUnits': units.length,
      'units': units,
    };
    manifestFile.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(manifest));
    print('    wrote manifest (${units.length} units)');

    courses.add({
      'code': code,
      'title': courseTitle ?? code,
      'totalUnits': units.length,
    });
  }

  // Master index
  File('$_coursesPath${separator}courses_index.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({'courses': courses}),
  );

  if (anyWorkDone) {
    print('\n  Done! ${courses.length} courses indexed.');
  } else {
    print('\n  Nothing to do — all courses already processed.');
  }
}

// ── helpers ──────────────────────────────────────────────────────────

String get separator => Platform.pathSeparator;

String? _readText(String dirPath) {
  final d = Directory(dirPath);
  if (!d.existsSync()) return null;
  final files = d.listSync().whereType<File>().toList();
  return files.isEmpty ? null : files.first.readAsStringSync();
}

String? _readFileMaybe(String path) {
  final f = File(path);
  return f.existsSync() ? f.readAsStringSync() : null;
}

String? _findFile(String dirPath, String ext) {
  final d = Directory(dirPath);
  if (!d.existsSync()) return null;
  final files = d.listSync().whereType<File>().toList();
  if (files.isEmpty) return null;
  final match = files.where((f) => f.path.toLowerCase().endsWith(ext)).toList();
  return match.isNotEmpty ? match.first.path : null;
}

int _countMatches(String? content, RegExp pattern) {
  if (content == null) return 0;
  return pattern.allMatches(content).length;
}

void _writeFile(String path, String? content) {
  if (content != null) File(path).writeAsStringSync(content);
}

/// Extract a human-readable unit title from available content.
///
/// Priority order:
///   1. Arabic `الفصل {ordinal}:` header in lecture (IIS202 style)
///   2. Quiz heading with `اختبار` noise stripped
///   3. Flashcard heading with `بطاقات` / `قواعد` / `معطيات` noise stripped
///   4. First `# ` heading in lecture (non-numbered, within first 50 lines)
///   5. Fallback `Unit {id}`
String _extractTitle({
  String? lectureContent,
  String? quizContent,
  String? flashcardContent,
  required String unitId,
}) {
  // 1) Arabic chapter header: الفصل {ordinal}:
  if (lectureContent != null) {
    final lines = LineSplitter.split(lectureContent).toList();
    for (int i = 0; i < lines.length - 1; i++) {
      if (RegExp(r'^الفصل\s+\S+:?\s*$').hasMatch(lines[i].trim())) {
        final titleLine = lines[i + 1].trim();
        if (titleLine.isNotEmpty && !titleLine.startsWith('---')) {
          return titleLine;
        }
      }
    }
  }

  // 2) Quiz heading: # {text}, strip اختبار
  if (quizContent != null) {
    for (final line in LineSplitter.split(quizContent)) {
      final t = line.trim();
      if (t.startsWith('# ')) {
        String title = t.substring(2).trim();
        title = title.replaceFirst(RegExp(r'^اختبار\s*'), '').trim();
        title = title.replaceFirst(RegExp(r'\s*اختبار$'), '').trim();
        if (title.isNotEmpty) return title;
      }
    }
  }

  // 3) Lecture heading (only if early in file, skip numbered TOC entries)
  //    (before flashcard so INT203 picks up the real chapter title)
  if (lectureContent != null) {
    final lines = LineSplitter.split(lectureContent).toList();
    for (int i = 0; i < lines.length && i < 50; i++) {
      final t = lines[i].trim();
      if (t.startsWith('# ') && !RegExp(r'^# \d+\.').hasMatch(t)) {
        return t.substring(2).trim();
      }
    }
  }

  // 4) Flashcard heading: # {text}, strip بطاقات / قواعد / معطيات
  if (flashcardContent != null) {
    for (final line in LineSplitter.split(flashcardContent)) {
      final t = line.trim();
      if (t.startsWith('# ')) {
        String title = t.substring(2).trim();
        for (final noise in ['بطاقات', 'قواعد', 'معطيات']) {
          title = title.replaceFirst(RegExp('^$noise\\s*'), '').trim();
        }
        if (title.isNotEmpty) return title;
      }
    }
  }

  return 'Unit $unitId';
}

/// Derive course-level title from the first unit's lecture file before flattening.
String? _deriveCourseTitleFromNested(String firstUnitPath, String courseCode) {
  final mdDir = Directory('$firstUnitPath${separator}markdowns');
  if (!mdDir.existsSync()) return null;
  final files = mdDir.listSync().whereType<File>().toList();
  if (files.isEmpty) return null;
  final name = files.first.path.split(separator).last;
  final match = RegExp(r'^(.+?)(?:_CH\d+|_\d+)\.\w+$').firstMatch(name);
  if (match != null) return match.group(1)!.trim();
  return null;
}

/// Derive course-level title from already-flat lecture file.
String? _deriveCourseTitleFromFlat(
    String courseCode, String coursePath, String firstUnitId) {
  final prefix = '${courseCode}_$firstUnitId';
  final f = File('$coursePath${separator}${prefix}_lecture.md');
  if (!f.existsSync()) return null;
  final content = f.readAsStringSync();
  // Try الفصل header first
  for (final line in LineSplitter.split(content)) {
    final t = line.trim();
    if (RegExp(r'^الفصل\s+\S+:?\s*$').hasMatch(t)) return null;
    // Not a reliable source; we can't derive course title from flat file
    // easily. Just return null → will use courseCode.
  }
  return null;
}
