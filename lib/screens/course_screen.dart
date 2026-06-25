import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/course_service.dart';
import '../services/analytics_service.dart';

class CourseScreen extends StatefulWidget {
  final String courseCode;
  final bool isDownloaded;

  const CourseScreen({super.key, required this.courseCode, this.isDownloaded = false});

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
    try {
      _manifest = await CourseService.loadManifest(widget.courseCode);
    } catch (e) {
      AnalyticsService.instance.recordError(e, StackTrace.current, context: 'course_screen._loadManifest');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<String> _getFilePath(String fileName) async {
    final dir = await CourseService.getCourseDir(widget.courseCode);
    return '$dir/$fileName';
  }

  void _showUnitOptions(Map<String, dynamic> unit) async {
    final pdfPath = unit['pdf'] as String;

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
                onTap: () async {
                  Navigator.pop(ctx);
                  AnalyticsService.instance.logUnitOptionSelected(
                    widget.courseCode, unit['id'] as String, 'pdf',
                  );
                  final path = await _getFilePath(pdfPath);
                  if (!mounted) return;
                  context.push(
                    '/course/${widget.courseCode}/pdf/${unit['id']}',
                    extra: {
                      'filePath': path,
                      'isDownloaded': widget.isDownloaded,
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.quiz_outlined),
                title: const Text('Quiz'),
                subtitle: Text('${unit['quizCount']} سؤال'),
                onTap: () {
                  Navigator.pop(ctx);
                  AnalyticsService.instance.logUnitOptionSelected(
                    widget.courseCode, unit['id'] as String, 'quiz',
                  );
                  context.push(
                    '/course/${widget.courseCode}/quiz/${unit['id']}',
                    extra: widget.isDownloaded,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.style_outlined),
                title: const Text('Flashcards'),
                subtitle: Text('${unit['flashcardCount']} بطاقة'),
                onTap: () {
                  Navigator.pop(ctx);
                  AnalyticsService.instance.logUnitOptionSelected(
                    widget.courseCode, unit['id'] as String, 'flashcard',
                  );
                  context.push(
                    '/course/${widget.courseCode}/flashcard/${unit['id']}',
                    extra: widget.isDownloaded,
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
          : _manifest == null
              ? const Center(child: Text('فشل تحميل المقرر'))
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
