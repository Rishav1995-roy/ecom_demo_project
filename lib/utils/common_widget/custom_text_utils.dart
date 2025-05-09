import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextUtils {
  CustomTextUtils._();

  static TextStyle showPoppinsStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color fontColor,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: fontColor,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: fontColor,
      ),
    );
  }
}
