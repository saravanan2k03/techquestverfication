import 'package:flutter/material.dart';

import 'views/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TECHQUEST',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 77, 36, 147)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
