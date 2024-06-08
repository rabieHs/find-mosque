import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageViewWidget extends StatelessWidget {
  final String image;
  final String title;
  const PageViewWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.locale,
  }) : super(key: key);

  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: defaultTitleTextStyle,
              ),
              Text(
                locale.easyToUse,
                style: defaultSubtitleTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
