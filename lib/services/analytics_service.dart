import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._();
  static AnalyticsService get instance => _instance;

  FirebaseAnalytics? _analytics;
  FirebaseCrashlytics? _crashlytics;

  AnalyticsService._();

  Future<void> init() async {
    _analytics = FirebaseAnalytics.instance;
    try {
      _crashlytics = FirebaseCrashlytics.instance;
      await _crashlytics!.setCrashlyticsCollectionEnabled(true);
    } catch (_) {
      _crashlytics = null;
    }
  }

  void logScreenView(String screenName) {
    _analytics?.logScreenView(screenName: screenName, screenClass: screenName);
  }

  void logAppOpen() {
    _analytics?.logAppOpen();
  }

  void logNewCoursesAvailable(int count) {
    _analytics?.logEvent(
      name: 'new_courses_available',
      parameters: {'count': count},
    );
  }

  void logCourseTap(String courseCode) {
    _analytics?.logEvent(
      name: 'course_tap',
      parameters: {'course_code': courseCode},
    );
  }

  void logDownloadStarted(String courseCode) {
    _analytics?.logEvent(
      name: 'download_started',
      parameters: {'course_code': courseCode},
    );
  }

  void logDownloadCompleted(String courseCode) {
    _analytics?.logEvent(
      name: 'download_completed',
      parameters: {'course_code': courseCode},
    );
  }

  void logDownloadFailed(String courseCode, String error) {
    _analytics?.logEvent(
      name: 'download_failed',
      parameters: {'course_code': courseCode, 'error': error},
    );
  }

  void logUnitOptionSelected(String courseCode, String unitId, String option) {
    _analytics?.logEvent(
      name: 'unit_option_selected',
      parameters: {
        'course_code': courseCode,
        'unit_id': unitId,
        'option': option,
      },
    );
  }

  void logQuizStarted(String courseCode, String unitId, int questionCount) {
    _analytics?.logEvent(
      name: 'quiz_started',
      parameters: {
        'course_code': courseCode,
        'unit_id': unitId,
        'question_count': questionCount,
      },
    );
  }

  void logQuizCompleted(
    String courseCode,
    String unitId,
    int correct,
    int total,
  ) {
    _analytics?.logEvent(
      name: 'quiz_completed',
      parameters: {
        'course_code': courseCode,
        'unit_id': unitId,
        'correct': correct,
        'total': total,
        'score_pct': total > 0 ? (correct / total * 100).round() : 0,
      },
    );
  }

  void logQuizResultViewed(
    String courseCode,
    String unitId,
    int correct,
    int total,
  ) {
    _analytics?.logEvent(
      name: 'quiz_result_viewed',
      parameters: {
        'course_code': courseCode,
        'unit_id': unitId,
        'correct': correct,
        'total': total,
        'score_pct': total > 0 ? (correct / total * 100).round() : 0,
      },
    );
  }

  void logQuizRestarted(String courseCode, String unitId) {
    _analytics?.logEvent(
      name: 'quiz_restarted',
      parameters: {'course_code': courseCode, 'unit_id': unitId},
    );
  }

  void logQuizReviewStarted(String courseCode, String unitId) {
    _analytics?.logEvent(
      name: 'quiz_review_started',
      parameters: {'course_code': courseCode, 'unit_id': unitId},
    );
  }

  void logQuizPdfReferenced(String courseCode, String unitId) {
    _analytics?.logEvent(
      name: 'quiz_pdf_referenced',
      parameters: {'course_code': courseCode, 'unit_id': unitId},
    );
  }

  void logFlashcardStarted(String courseCode, String unitId, int cardCount) {
    _analytics?.logEvent(
      name: 'flashcard_started',
      parameters: {
        'course_code': courseCode,
        'unit_id': unitId,
        'card_count': cardCount,
      },
    );
  }

  void recordError(
    dynamic error,
    StackTrace stack, {
    String? context,
    bool fatal = false,
  }) {
    _crashlytics?.recordError(error, stack, reason: context, fatal: fatal);
  }

  void logBreadcrumb(String message) {
    _crashlytics?.log(message);
  }
}
