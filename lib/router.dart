import 'package:go_router/go_router.dart';
import 'models/course.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/course_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/flashcard_screen.dart';
import 'screens/pdf_screen.dart';
import 'services/analytics_service.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) =>
          HomeScreen(newCourses: state.extra as List<Course>? ?? []),
    ),
    GoRoute(
      path: '/course/:courseCode',
      name: 'course',
      builder: (context, state) => CourseScreen(
        courseCode: state.pathParameters['courseCode']!,
        isDownloaded: state.extra as bool? ?? false,
      ),
    ),
    GoRoute(
      path: '/course/:courseCode/quiz/:unitId',
      name: 'quiz',
      builder: (context, state) => QuizScreen(
        courseCode: state.pathParameters['courseCode']!,
        unitId: state.pathParameters['unitId']!,
        isDownloaded: state.extra as bool? ?? false,
      ),
    ),
    GoRoute(
      path: '/course/:courseCode/flashcard/:unitId',
      name: 'flashcard',
      builder: (context, state) => FlashcardScreen(
        courseCode: state.pathParameters['courseCode']!,
        unitId: state.pathParameters['unitId']!,
        isDownloaded: state.extra as bool? ?? false,
      ),
    ),
    GoRoute(
      path: '/course/:courseCode/pdf/:unitId',
      name: 'pdf',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return PdfScreen(
          courseCode: state.pathParameters['courseCode']!,
          unitId: state.pathParameters['unitId']!,
          filePath: extra['filePath'] as String? ?? '',
          initialPage: extra['initialPage'] as int?,
          isDownloaded: extra['isDownloaded'] as bool? ?? false,
        );
      },
    ),
  ],
);

String? _lastScreenName;

void _onRouterChange() {
  final matches = router.routerDelegate.currentConfiguration.matches;
  if (matches.isEmpty) return;
  final route = matches.last.route;
  final name = (route as GoRoute).name;
  if (name != null && name != _lastScreenName) {
    _lastScreenName = name;
    AnalyticsService.instance.logScreenView(name);
  }
}

void setupScreenTracking() =>
    router.routerDelegate.addListener(_onRouterChange);
