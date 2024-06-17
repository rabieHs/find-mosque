import 'package:flutter/material.dart';

import '../../../../core/constants/styles/paddings.dart';
import '../../../../core/constants/styles/shapes.dart';
import '../../../../core/constants/styles/text_styles.dart';
import '../../domain/entities/prayer.dart';

class PrayerTimeCard extends StatelessWidget {
  const PrayerTimeCard({
    super.key,
    required this.prayer,
  });

  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
          contentPadding: customPadding(8, 30),
          shape: customRoundedShape(15),
          tileColor: Colors.white.withOpacity(0.3),
          leading: Image.asset(prayer.image, width: 50, height: 50),
          title: Text(
            prayer.name,
            style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            prayer.time,
            style: defaultTextStyle,
          )),
    );
  }
}
