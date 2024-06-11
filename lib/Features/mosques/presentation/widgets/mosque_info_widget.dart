import 'package:flutter/material.dart';

import '../../../../core/constants/styles/text_styles.dart';
import '../../../landing/presentation/widgets/circle_progress_button.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/mosque.dart';
import 'custom_info_widget.dart';

class MosqueInfoWidget extends StatelessWidget {
  const MosqueInfoWidget(
      {super.key, required this.location, required this.mosque});

  final Location location;
  final Mosque mosque;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          "assets/icons/marker_info.png",
          width: 75,
          height: 75,
          scale: 1,
        ),
        Text(
          location.name,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/man.png"),
            const SizedBox(
              width: 5,
            ),
            Image.asset("assets/icons/women.png"),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomInfoWidget(
              icon: Icons.location_pin,
              title: "data",
              subTitle: "7KM",
            ),
            CustomInfoWidget(
              icon: Icons.timer,
              title: "data",
              subTitle: "15:00 PM",
            ),
          ],
        ),
        Text(
          "data",
          style: defaultSubtitleTextStyle,
        ),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomInfoWidget(
              icon: Icons.mosque,
              title: "data",
              subTitle: "7KM",
            ),
            CustomInfoWidget(
              icon: Icons.mosque,
              title: "data",
              subTitle: "15:00 PM",
            ),
            CustomInfoWidget(
              icon: Icons.mosque,
              title: "data",
              subTitle: "15:00 PM",
            ),
          ],
        ),
        const CircleProgressButton(
          pageProgress: 100,
        )
      ],
    );
  }
}
