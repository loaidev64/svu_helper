import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import '../services/download_service.dart';
import '../services/analytics_service.dart';

class HomeScreen extends StatefulWidget {
  final List<Course> newCourses;

  const HomeScreen({super.key, this.newCourses = const []});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Course> _courses = [];
  List<Course> _newCourses = [];
  final Set<String> _downloadingCodes = {};
  final Map<String, double> _downloadProgress = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _newCourses = List<Course>.from(widget.newCourses);
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      final local = await CourseService.loadLocalCourses();
      final downloaded = await CourseService.loadDownloadedCourses();
      final merged = <Course>[];
      final seen = <String>{};
      for (final c in downloaded) {
        if (!seen.contains(c.code)) {
          merged.add(c);
          seen.add(c.code);
        }
      }
      for (final c in local) {
        if (!seen.contains(c.code)) {
          merged.add(Course.fromJson(c.toJson(), isDownloaded: false));
          seen.add(c.code);
        }
      }
      setState(() {
        _courses = merged;
        _loading = false;
      });
    } catch (e) {
      AnalyticsService.instance.recordError(e, StackTrace.current, context: 'home_screen._loadCourses');
      final local = await CourseService.loadLocalCourses();
      setState(() {
        _courses = local;
        _loading = false;
      });
    }
  }

  Future<void> _startDownload(String courseCode) async {
    AnalyticsService.instance.logDownloadStarted(courseCode);
    setState(() {
      _downloadingCodes.add(courseCode);
      _downloadProgress[courseCode] = 0;
    });

    try {
      await DownloadService.downloadCourse(
        courseCode,
        onProgress: (p) {
          if (mounted) {
            setState(() {
              _downloadProgress[courseCode] = p;
            });
          }
        },
        onFileProgress: (fileName, fileP) {},
      );
      await CourseService.markCourseDownloaded(courseCode);
      AnalyticsService.instance.logDownloadCompleted(courseCode);
      if (mounted) {
        setState(() {
          _downloadingCodes.remove(courseCode);
          _downloadProgress.remove(courseCode);
          final course = _newCourses.firstWhere((c) => c.code == courseCode);
          _newCourses.remove(course);
          _courses.insert(
            0,
            Course.fromJson(course.toJson(), isDownloaded: true),
          );
        });
      }
    } catch (e) {
      AnalyticsService.instance.logDownloadFailed(courseCode, e.toString());
      if (mounted) {
        setState(() {
          _downloadingCodes.remove(courseCode);
          _downloadProgress.remove(courseCode);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SVU Helper'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _courses.length + _newCourses.length,
              itemBuilder: (context, i) {
                if (i < _courses.length) {
                  return _buildCourseCard(_courses[i]);
                }
                return _buildNewCourseCard(_newCourses[i - _courses.length]);
              },
            ),
    );
  }

  Widget _buildCourseCard(Course c) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${c.totalUnits}'),
        ),
        title: Text(c.title),
        subtitle: Text('${c.code} · ${c.totalUnits} وحدة'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          AnalyticsService.instance.logCourseTap(c.code);
          context.push('/course/${c.code}', extra: c.isDownloaded);
        },
      ),
    );
  }

  Widget _buildNewCourseCard(Course c) {
    final isDownloading = _downloadingCodes.contains(c.code);
    final progress = _downloadProgress[c.code] ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text('${c.totalUnits}'),
              ),
              title: Text(c.title),
              subtitle: Text('${c.code} · ${c.totalUnits} وحدة'),
              trailing: isDownloading
                  ? SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        value: progress > 0 ? progress : null,
                        strokeWidth: 3,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.download),
                      tooltip: 'تحميل',
                      onPressed: () => _startDownload(c.code),
                    ),
            ),
            if (isDownloading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LinearProgressIndicator(
                  value: progress > 0 ? progress : null,
                ),
              ),
            if (isDownloading) const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
