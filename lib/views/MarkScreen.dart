import 'package:flutter/material.dart';
import 'package:techquest/views/MarkData.dart';

import '../widgets/drawer.dart';

class MarkPage extends StatefulWidget {
  const MarkPage({super.key});

  @override
  State<MarkPage> createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          DrawerPage(),
          MarkData(),
        ],
      ),
    );
  }
}
