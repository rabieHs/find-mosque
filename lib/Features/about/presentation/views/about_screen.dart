import 'package:dartz/dartz.dart';
import 'package:find_mosques/core/constants/styles/paddings.dart';
import 'package:find_mosques/core/constants/styles/text_styles.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/widgets/custom_header.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          CustomHeader(title: locale.aboutApp),
          _buildBody(context, locale),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, locale) {
    return Expanded(
      child: Padding(
        padding: customPadding(15, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/luanch_logo.png",
                  width: context.screenWidht() * 0.3,
                ),
                Padding(
                  padding: customPadding(15, 0),
                  child: SizedBox(
                      width: context.screenWidht() * 0.8,
                      child: Text(
                        textAlign: TextAlign.center,
                        locale.aboutAppText,
                        style: defaultTextStyle.copyWith(color: Colors.black),
                      )),
                ),
              ],
            ),
            Text("Version 1.0.0"),
          ],
        ),
      ),
    );
  }
}
