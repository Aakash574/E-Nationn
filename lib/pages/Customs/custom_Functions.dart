// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

BoxDecoration customLeftBoxDecoration() {
  return BoxDecoration(
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(4),
      bottomRight: Radius.circular(4),
    ),
    border: Border.all(width: 1, color: MyColors.primaryColor),
    color: Colors.white,
    // color: Colors.blue,
  );
}

BoxDecoration customRightBoxDecoration() {
  return BoxDecoration(
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(4),
      bottomRight: Radius.circular(4),
    ),
    border: Border.all(width: 1, color: MyColors.primaryColor),
    color: Colors.white,
    // color: Colors.blue,
  );
}
