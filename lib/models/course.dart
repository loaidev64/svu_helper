class Course {
  final String code;
  final String title;
  final int totalUnits;
  final bool isDownloaded;
  final bool isNew;

  const Course({
    required this.code,
    required this.title,
    required this.totalUnits,
    this.isDownloaded = false,
    this.isNew = false,
  });

  factory Course.fromJson(Map<String, dynamic> json, {bool isDownloaded = false, bool isNew = false}) {
    return Course(
      code: json['code'] as String,
      title: json['title'] as String,
      totalUnits: json['totalUnits'] as int,
      isDownloaded: isDownloaded,
      isNew: isNew,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'title': title,
        'totalUnits': totalUnits,
      };
}
