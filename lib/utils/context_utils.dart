import 'package:ecom_demo/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExtensionFunctions on BuildContext {
  double getWidth() => MediaQuery.of(this).size.width;

  double getHeight() => MediaQuery.of(this).size.height;

  void afterWidgetBuilt(Function() functionToCall, {Function()? checkMounted}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => functionToCall());
    if (checkMounted != null) {
      if (mounted) {
        checkMounted();
      }
    }
  }

  Widget paddingHorizontal(double size) {
    return SizedBox(
      width: size,
    );
  }

  Widget paddingVertical(double size) {
    return SizedBox(
      height: size,
    );
  }

  convertCurrencyInBottomSheet(double number) {
    NumberFormat numberFormat = NumberFormat("#,##,##0", "en_US");
    return "${Strings.rupeesText} ${numberFormat.format(number)}";
  }
}
