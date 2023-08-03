import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyColors {
  // Main Colors -------------------->
  static Color primaryColor = const Color.fromARGB(255, 0, 74, 173);
  static Color secondPrimaryColor = const Color.fromARGB(255, 29, 58, 112);
  static Color secondaryColor = const Color.fromARGB(255, 251, 187, 0);
  static Color lightBlueColor = const Color.fromARGB(255, 102, 146, 206);
  static Color darkGreyColor = const Color.fromARGB(255, 107, 114, 128);
  static Color lightGreyColor = const Color.fromARGB(255, 150, 167, 175);
  static Color lightOrangeColor = const Color.fromARGB(255, 245, 151, 98);
  static Color tealGreenColor = const Color.fromARGB(255, 38, 198, 140);
  static Color lightGreenColor = const Color.fromARGB(255, 75, 174, 79);
}

class MyFont {
  //<--------------------------- Size - 26 --------------------------->
  // Text Size 26 Bold
  Text fontSize26Bold(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 26 Light
  Text fontSize26Light(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w300,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 26 Weight 500
  Text fontSize26Weight500(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 26,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 26 Weight 700
  Text fontSize26Weight700(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 26 Weight 900
  Text fontSize26Weight900(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          color: fontColor,
        ),
      ),
    );
  }

  //<--------------------------- Size - 20 --------------------------->

  // Text Size 20 Bold
  Text fontSize20Bold(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 20 Light
  Text fontSize20Light(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 20 Weight 500
  Text fontSize20Weight500(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 20,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 20 Weight 700
  Text fontSize20Weight700(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 20 Weight 900
  Text fontSize20Weight900(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: fontColor,
        ),
      ),
    );
  }

  //<--------------------------- Size - 18 --------------------------->

  // Text Size 18 Bold
  Text fontSize18Bold(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 18 Light
  Text fontSize18Light(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 18 Weight 500
  Text fontSize18Weight500(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18,
          // fontWeight: FontWeight.w500,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 18 Weight 700
  Text fontSize18Weight700(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 18 Weight 900
  Text fontSize18Weight900(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: fontColor,
        ),
      ),
    );
  }

  //<--------------------------- Size - 16 --------------------------->

  // Text Size 16 Bold
  Text fontSize16Bold(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 16 Light
  Text fontSize16Light(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 16 Weight 500
  Text fontSize16Weight500(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 16 Weight 700
  Text fontSize16Weight700(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 16 Weight 900
  Text fontSize16Weight900(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: fontColor,
        ),
      ),
    );
  }

  //<--------------------------- Size - 14 --------------------------->

  // Text Size 14 Bold
  Text fontSize14Bold(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 14 Light
  Text fontSize14Light(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 14 Weight 500
  Text fontSize14Weight500(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 14 Weight 700
  Text fontSize14Weight700(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 14 Weight 900
  Text fontSize14Weight900(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: fontColor,
        ),
      ),
    );
  }
  //<--------------------------- Size - 12 --------------------------->

  // Text Size 12 Bold
  Text fontSize12Bold(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 12 Light
  Text fontSize12Light(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 12 Weight 500
  Text fontSize12Weight500(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 12 Weight 700
  Text fontSize12Weight700(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 12 Weight 900
  Text fontSize12Weight900(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: fontColor,
        ),
      ),
    );
  }
  //<--------------------------- Size - 10 --------------------------->

  // Text Size 10 Bold
  Text fontSize10Bold(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 10 Light
  Text fontSize10Light(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w300,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 10 Weight 500
  Text fontSize10Weight500(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 10,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 10 Weight 700
  Text fontSize10Weight700(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
      ),
    );
  }

  // Text Size 10 Weight 900
  Text fontSize10Weight900(String text, Color fontColor) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: fontColor,
        ),
      ),
    );
  }
}
