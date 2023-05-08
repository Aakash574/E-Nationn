// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WorkShopScreen extends StatefulWidget {
  const WorkShopScreen({super.key});

  @override
  State<WorkShopScreen> createState() => _WorkShopScreenState();
}

class _WorkShopScreenState extends State<WorkShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("assets/ExtrasScreens/comingSoon.png"),
    );
  }
}
