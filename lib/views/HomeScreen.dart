import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'Entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          DrawerPage(),
          Entry(),
        ],
      ),
    );
  }
}
