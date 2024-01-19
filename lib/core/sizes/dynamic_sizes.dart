import 'package:flutter/material.dart';

extension DynamicSizes on BuildContext {
  double screenHeight(double height) => MediaQuery.sizeOf(this).height * height;
  double screenWidth(double width) => MediaQuery.sizeOf(this).height * width;
}
