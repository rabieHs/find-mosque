import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/constants/styles/paddings.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/Features/prayer/presentation/controllers/bloc/prayer_bloc.dart';
import 'package:find_mosques/core/widgets/next_prayer_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/styles/text_styles.dart';
import '../../../../core/widgets/custom_icon_menu_button.dart';
import '../../Features/prayer/domain/entities/prayer.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  const CustomHeader({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _header(context);
  }

  Container _header(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Container(
      height: context.screenHeight() * 0.16,
      padding: customPadding(15, 30),
      color: primaryColor,
      child: Row(
        children: [
          Expanded(
              child: Align(
                  alignment: locale.localeName == "ar"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: const CustomIconMenuButton())),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: largeTitleTextStyle,
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
