import 'package:flutter/material.dart';

class NextPrayerShimmerWidget extends StatelessWidget {
  const NextPrayerShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _buildContainer(16.0, 100.0),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildContainer(30.0, 30.0),
                ),
              ),
              Expanded(child: _buildContainer(16.0, 16.0)),
            ],
          ),
          const SizedBox(height: 10.0),
          _buildContainer(16.0, 150.0),
          const SizedBox(height: 5.0),
          _buildContainer(16.0, 100.0),
          const SizedBox(height: 5.0),
          _buildContainer(16.0, 120.0),
        ],
      ),
    );
  }

  Widget _buildContainer(double height, double width) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.5),
      ),
      width: width,
      height: height,
    );
  }
}
