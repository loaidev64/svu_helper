import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/course.dart';
import '../utils/io_stub.dart' if (dart.library.io) 'dart:io';

class CourseService {
  static String? _docsPath;

  static Future<String> get _courseBasePath async {
    if (kIsWeb) return '';
    if (_docsPath != null) return '$_docsPath/courses';
    final dir = await getApplicationDocumentsDirectory();
    _docsPath = dir.path;
    return '$_docsPath/courses';
  }

  static Future<List<Course>> loadLocalCourses() async {
    final raw = await rootBundle.loadString('assets/courses/courses_index.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['courses'] as List<dynamic>).cast<Map<String, dynamic>>();
    return list.map((c) => Course.fromJson(c)).toList();
  }

  static Future<List<Course>> loadDownloadedCourses() async {
    if (kIsWeb) return [];
    final base = await _courseBasePath;
    final dir = Directory(base);
    if (!dir.existsSync()) return [];
    final courses = <Course>[];
    for (final entry in dir.listSync()) {
      if (entry is! Directory) continue;
      final code = entry.path.split(Platform.pathSeparator).last;
      if (code.startsWith('.')) continue;
      final manifest = File('${entry.path}${Platform.pathSeparator}manifest.json');
      if (!manifest.existsSync()) continue;
      try {
        final data = jsonDecode(await manifest.readAsString()) as Map<String, dynamic>;
        courses.add(Course.fromJson(data, isDownloaded: true));
      } catch (_) {}
    }
    return courses;
  }

  static Future<bool> isCourseDownloaded(String courseCode) async {
    if (kIsWeb) return false;
    final base = await _courseBasePath;
    return Directory('$base/$courseCode').existsSync();
  }

  static Future<String> readCourseFile(String courseCode, String fileName) async {
    if (!kIsWeb) {
      final base = await _courseBasePath;
      final file = File('$base/$courseCode/$fileName');
      if (await file.exists()) {
        return await file.readAsString();
      }
    }
    return rootBundle.loadString('assets/courses/$courseCode/$fileName');
  }

  static Future<String> getCourseDir(String courseCode) async {
    if (!kIsWeb) {
      final base = await _courseBasePath;
      final fileDir = '$base/$courseCode';
      if (Directory(fileDir).existsSync()) return fileDir;
    }
    return 'assets/courses/$courseCode';
  }

  static Future<Map<String, dynamic>> loadManifest(String courseCode) async {
    final raw = await readCourseFile(courseCode, 'manifest.json');
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<void> markCourseDownloaded(String courseCode) async {
    if (kIsWeb) return;
    final base = await _courseBasePath;
    final stateDir = Directory('$base/.downloads');
    if (!stateDir.existsSync()) stateDir.createSync(recursive: true);
    final stateFile = File('${stateDir.path}/${Platform.pathSeparator}$courseCode.json');
    final state = stateFile.existsSync()
        ? jsonDecode(await stateFile.readAsString()) as Map<String, dynamic>
        : <String, dynamic>{};
    state['overall'] = 'completed';
    await stateFile.writeAsString(const JsonEncoder.withIndent('  ').convert(state));
  }
}
