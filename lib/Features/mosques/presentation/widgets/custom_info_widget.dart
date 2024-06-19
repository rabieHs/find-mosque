import 'package:flutter/widgets.dart';

import '../../../../core/constants/colors/colors.dart';
import '../../../../core/constants/styles/text_styles.dart';

class CustomInfoWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  const CustomInfoWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(subTitle),
          ],
        ),
        Text(
          title,
          style: defaultSubtitleTextStyle,
        )
      ],
    );
  }
}
