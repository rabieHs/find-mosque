import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

import '../constants/colors/colors.dart';

class CircleProgressButton extends StatelessWidget {
  IconData icon;
  Color backgroundColor;
  Color forgroundColor;
  double? pageProgress;
  void Function()? onTap;

  CircleProgressButton(
      {this.backgroundColor = const Color.fromRGBO(0, 126, 106, 1),
      this.forgroundColor = const Color.fromRGBO(113, 192, 102, 1),
      this.pageProgress = 100,
      this.onTap,
      super.key,
      this.icon = Icons.arrow_back});

  @override
  Widget build(BuildContext context) {
    return DashedCircularProgressBar.square(
      dimensions: 70,
      progress: pageProgress!,
      maxProgress: 100,
      startAngle: 0,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInCirc,
      foregroundColor: forgroundColor,
      backgroundColor: const Color(0xffeeeeee),
      foregroundStrokeWidth: 5,
      backgroundStrokeWidth: 5,
      foregroundGapSize: 10,
      foregroundDashSize: 80,
      backgroundGapSize: 10,
      backgroundDashSize: 80,
      animation: true,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
              backgroundColor: backgroundColor,
              child: Icon(icon, color: Colors.white, size: 30)),
        ),
      ),
    );
  }
}
