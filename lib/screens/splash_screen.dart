import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:go_router/go_router.dart';
import '../services/course_service.dart';
import '../services/download_service.dart';
import '../services/analytics_service.dart';
import '../models/course.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Course> _newCourses = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        final result = await Connectivity().checkConnectivity();
        if (result.any((c) => c != ConnectivityResult.none)) {
          final remote = await DownloadService.fetchRemoteIndex();
          if (remote != null) {
            final local = await CourseService.loadLocalCourses();
            final downloaded = await CourseService.loadDownloadedCourses();
            _newCourses = DownloadService.getNewCourses(remote, [...local, ...downloaded]);
          }
        }
      } catch (_) {
        AnalyticsService.instance.logBreadcrumb('Failed to fetch remote courses on splash');
      }
    }

    AnalyticsService.instance.logAppOpen();
    if (_newCourses.isNotEmpty) {
      AnalyticsService.instance.logNewCoursesAvailable(_newCourses.length);
    }

    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/home', extra: _newCourses);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'SVU Helper',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'منصة تعليمية مساعدة',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'هذا التطبيق ومحتواه من إنشاء الذكاء الاصطناعي. يرجى مراجعة المعلومات والتحقق من دقتها.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
