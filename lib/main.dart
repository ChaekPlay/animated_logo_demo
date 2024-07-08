import 'package:animated_logo_demo/components/animated_loading_logo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedLoadingDemo(
            displayText: "Загрузка",
          ),
        ),
      ),
    );
  }
}
