import 'package:assignments/core/config/configure_dependencies.dart';
import 'package:assignments/feature/quiz/presentation/page/quiz_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizPage(title: 'Tockto Quiz Demo'),
    );
  }
}
