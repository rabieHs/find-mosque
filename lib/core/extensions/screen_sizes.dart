import 'package:flutter/material.dart';

extension ScreenSizes on BuildContext {
  double screenHeight() => MediaQuery.of(this).size.height;
  double screenWidht() => MediaQuery.of(this).size.width;
}
