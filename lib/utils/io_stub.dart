// Stub implementations of dart:io types for platforms where dart:io is
// unavailable (e.g. web). The real implementations from dart:io are imported
// conditionally via `if (dart.library.io)` everywhere this is used.

abstract class Platform {
  static const String pathSeparator = '/';
}

abstract class FileSystemEntity {
  String get path => '';
}

class Directory implements FileSystemEntity {
  Directory(String path);

  @override
  String get path => '';

  bool existsSync() => false;

  Future<bool> exists() async => false;

  List<FileSystemEntity> listSync() => [];

  Future<Directory> create({bool recursive = false}) async => throw UnsupportedError('FileSystem not available on this platform');

  void createSync({bool recursive = false}) => throw UnsupportedError('FileSystem not available on this platform');

  Future<void> delete({bool recursive = false}) async => throw UnsupportedError('FileSystem not available on this platform');

  void deleteSync({bool recursive = false}) => throw UnsupportedError('FileSystem not available on this platform');
}

class File implements FileSystemEntity {
  File(String path);

  @override
  String get path => '';

  Future<bool> exists() async => false;

  bool existsSync() => false;

  Future<int> length() async => 0;

  Future<String> readAsString() async => throw UnsupportedError('FileSystem not available on this platform');

  String readAsStringSync() => throw UnsupportedError('FileSystem not available on this platform');

  IOSink openWrite({FileMode mode = FileMode.write}) => throw UnsupportedError('FileSystem not available on this platform');

  Future<File> writeAsString(String contents) async => throw UnsupportedError('FileSystem not available on this platform');

  Future<File> writeAsBytes(List<int> bytes) async => throw UnsupportedError('FileSystem not available on this platform');
}

enum FileMode { write, append }

class IOSink {
  void add(List<int> data) {}

  Future<void> addStream(Stream<List<int>> stream) async {}

  Future<void> flush() async {}

  Future<void> close() async {}
}
