import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/analytics_service.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AnalyticsService.instance.init();

  FlutterError.onError = (details) {
    AnalyticsService.instance.recordError(
      details.exception,
      details.stack ?? StackTrace.current,
      context: details.library,
    );
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AnalyticsService.instance.recordError(error, stack, fatal: true);
    return true;
  };

  setupScreenTracking();
  AnalyticsService.instance.logScreenView('splash');

  runApp(const SvuHelperApp());
}

class SvuHelperApp extends StatelessWidget {
  const SvuHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SVU Helper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
