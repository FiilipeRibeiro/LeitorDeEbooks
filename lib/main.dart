import 'package:flutter/material.dart';

import 'module/welcome/screen/welcome_screen.dart';
import 'consttants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book App',
      theme: ThemeData(
        scaffoldBackgroundColor: colorTwo,
      ),
      home: const WelcomeScreen(),
    );
  }
}
