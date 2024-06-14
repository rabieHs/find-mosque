import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/styles/paddings.dart';
import '../constants/styles/text_styles.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Container(
      margin: customPadding(10, 0),
      height: context.screenHeight() * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icons/search_icon.png", width: 60),
          Text(
            locale.noResult,
            style: defaultTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
