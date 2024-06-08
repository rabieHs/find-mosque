import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/colors.dart';

class CircleProgressButton extends StatelessWidget {
  const CircleProgressButton({
    super.key,
    required this.pageProgress,
  });

  final double pageProgress;

  @override
  Widget build(BuildContext context) {
    return DashedCircularProgressBar.square(
      dimensions: 70,
      progress: pageProgress,
      maxProgress: 100,
      startAngle: 0,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInCirc,
      foregroundColor: secondaryColor,
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
        child: CircleAvatar(
            backgroundColor: primaryColor,
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 30)),
      ),
    );
  }
}
