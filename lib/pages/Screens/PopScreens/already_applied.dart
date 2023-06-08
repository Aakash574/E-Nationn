// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AlreadyApplied extends StatefulWidget {
  const AlreadyApplied({super.key});

  @override
  State<AlreadyApplied> createState() => _AlreadyAppliedState();
}

class _AlreadyAppliedState extends State<AlreadyApplied> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => Navigator.pop(context),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SizedBox(
            height: size.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "You Already Applied",
                  style: TextStyle(
                    color: const Color(0xff979797),
                    fontSize: size.height / 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
