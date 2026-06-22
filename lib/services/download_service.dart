import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../models/course.dart';
import '../utils/io_stub.dart' if (dart.library.io) 'dart:io';

class DownloadService {
  static const _baseUrl = 'https://svu-helper.vercel.app/assets/assets/courses';
  static final _dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));

  static String? _docsPath;

  static Future<String> get _courseBasePath async {
    if (_docsPath != null) return '$_docsPath/courses';
    final dir = await getApplicationDocumentsDirectory();
    _docsPath = dir.path;
    return '$_docsPath/courses';
  }

  static Future<List<Course>?> fetchRemoteIndex() async {
    try {
      final res = await _dio.get('$_baseUrl/courses_index.json');
      final data = res.data as Map<String, dynamic>;
      final list = (data['courses'] as List<dynamic>).cast<Map<String, dynamic>>();
      return list.map((c) => Course.fromJson(c)).toList();
    } catch (_) {
      return null;
    }
  }

  static List<Course> getNewCourses(List<Course> remote, List<Course> local) {
    final localCodes = local.map((c) => c.code).toSet();
    return remote.where((c) => !localCodes.contains(c.code)).map((c) => Course.fromJson(c.toJson(), isNew: true)).toList();
  }

  static Future<void> downloadCourse(
    String courseCode, {
    void Function(double)? onProgress,
    void Function(String fileName, double fileProgress)? onFileProgress,
  }) async {
    final base = await _courseBasePath;
    final courseDir = Directory('$base/$courseCode');
    if (!courseDir.existsSync()) courseDir.createSync(recursive: true);

    final stateDir = Directory('$base/.downloads');
    if (!stateDir.existsSync()) stateDir.createSync(recursive: true);
    final stateFile = File('${stateDir.path}/${Platform.pathSeparator}$courseCode.json');

    Map<String, dynamic> state;
    if (stateFile.existsSync()) {
      state = jsonDecode(await stateFile.readAsString()) as Map<String, dynamic>;
    } else {
      state = {'files': <String, String>{}, 'overall': 'downloading'};
    }
    final files = state['files'] as Map<String, dynamic>? ?? <String, dynamic>{};
    state['files'] = files;

    final units = await _fetchManifestUnits(courseCode);
    final allFiles = _collectCourseFiles(courseCode, units);

    int completedCount = 0;
    final totalFiles = allFiles.length;

    for (final fileName in allFiles) {
      if (files[fileName] == 'completed') {
        completedCount++;
        if (onProgress != null) onProgress(completedCount / totalFiles);
        continue;
      }

      final remoteUrl = '$_baseUrl/$courseCode/$fileName';
      final localFile = File('${courseDir.path}/${Platform.pathSeparator}$fileName');
      final existingSize = await _getFileSizeIfExists(localFile);

      await _downloadFile(
        url: remoteUrl,
        dest: localFile,
        resumeAt: existingSize,
        onProgress: (fileProgress) {
          if (onFileProgress != null) onFileProgress(fileName, fileProgress);
        },
      );

      files[fileName] = 'completed';
      await stateFile.writeAsString(const JsonEncoder.withIndent('  ').convert(state));
      completedCount++;
      if (onProgress != null) onProgress(completedCount / totalFiles);
    }

    state['overall'] = 'completed';
    await stateFile.writeAsString(const JsonEncoder.withIndent('  ').convert(state));
  }

  static Future<List<Map<String, dynamic>>> _fetchManifestUnits(String courseCode) async {
    final res = await _dio.get('$_baseUrl/$courseCode/manifest.json');
    final data = res.data as Map<String, dynamic>;
    return (data['units'] as List<dynamic>).cast<Map<String, dynamic>>();
  }

  static List<String> _collectCourseFiles(String courseCode, List<Map<String, dynamic>> units) {
    final files = <String>['manifest.json'];
    for (final u in units) {
      final prefix = '${courseCode}_${u['id']}';
      files.add('${prefix}_lecture.md');
      files.add('${prefix}_quiz.json');
      files.add('${prefix}_flashcards.json');
      files.add('${prefix}_pdf.pdf');
    }
    return files;
  }

  static Future<int> _getFileSizeIfExists(File file) async {
    try {
      if (await file.exists()) return await file.length();
    } catch (_) {}
    return 0;
  }

  static Future<void> _downloadFile({
    required String url,
    required File dest,
    required int resumeAt,
    required void Function(double) onProgress,
  }) async {
    IOSink? sink;
    try {
      sink = dest.openWrite(mode: resumeAt > 0 ? FileMode.append : FileMode.write);

      await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.stream,
          headers: resumeAt > 0 ? {'Range': 'bytes=$resumeAt-'} : null,
        ),
        onReceiveProgress: (received, total) {
          final effectiveTotal = total == -1 ? (resumeAt + received) : (resumeAt + total);
          final effectiveReceived = resumeAt + received;
          onProgress(effectiveTotal > 0 ? effectiveReceived / effectiveTotal : 0);
        },
      ).then((res) async {
        await for (final chunk in (res.data as ResponseBody).stream) {
          sink!.add(chunk);
        }
      });
    } finally {
      await sink?.flush();
      await sink?.close();
    }
  }
}
