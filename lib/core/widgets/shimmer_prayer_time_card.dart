import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/styles/paddings.dart';
import '../constants/styles/shapes.dart';

class ShimmerPrayerTimeCard extends StatelessWidget {
  const ShimmerPrayerTimeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
            contentPadding: customPadding(8, 30),
            shape: customRoundedShape(15),
            tileColor: Colors.white.withOpacity(0.3),
            leading: _buildContainer(50, 50),
            title: _buildContainer(20, null),
            trailing: _buildContainer(20, 40)),
      ),
    );
  }

  Widget _buildContainer(double? height, double? width) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white.withOpacity(0.5),
      ),
      width: width,
      height: height,
    );
  }
}
