import 'package:flutter/material.dart';
import 'package:techquest/views/ArrivalData.dart';

import '../widgets/drawer.dart';

class ArrivalPage extends StatefulWidget {
  const ArrivalPage({super.key});

  @override
  State<ArrivalPage> createState() => _ArrivalPageState();
}

class _ArrivalPageState extends State<ArrivalPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          DrawerPage(),
          ArrivalData(),
        ],
      ),
    );
  }
}
