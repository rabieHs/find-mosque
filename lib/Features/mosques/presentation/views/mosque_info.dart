// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';

import '../../../../core/constants/styles/text_styles.dart';
import '../../../landing/presentation/widgets/circle_progress_button.dart';
import '../widgets/custom_info_widget.dart';

class MosqueInfo extends StatelessWidget {
  final Location location;
  const MosqueInfo({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.screenHeight() * 0.6,
      child: Column(
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
              SizedBox(
                width: 5,
              ),
              Image.asset("assets/icons/women.png"),
            ],
          ),
          Row(
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
          Divider(),
          Row(
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
          CircleProgressButton(
            pageProgress: 100,
          )
        ],
      ),
    );
  }
}
