import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'course_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _courses = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    final raw = await rootBundle.loadString('assets/courses/courses_index.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    setState(() {
      _courses = (data['courses'] as List<dynamic>).cast<Map<String, dynamic>>();
      _loading = false;
    });
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
              itemCount: _courses.length,
              itemBuilder: (context, i) {
                final c = _courses[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${c['totalUnits']}'),
                    ),
                    title: Text(c['title'] as String),
                    subtitle: Text('${c['code']} · ${c['totalUnits']} وحدة'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CourseScreen(courseCode: c['code'] as String),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
