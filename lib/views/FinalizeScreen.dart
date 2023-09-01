import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'FinalizeData.dart';

class FinalizeScreen extends StatefulWidget {
  const FinalizeScreen({super.key});

  @override
  State<FinalizeScreen> createState() => _FinalizeScreenState();
}

class _FinalizeScreenState extends State<FinalizeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          DrawerPage(),
          FinalizeData(),
        ],
      ),
    );
  }
}
