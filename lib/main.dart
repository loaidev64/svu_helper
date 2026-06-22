import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SvuHelperApp());
}

class SvuHelperApp extends StatelessWidget {
  const SvuHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVU Helper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
