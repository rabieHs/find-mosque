// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:find_mosques/Features/language/presentation/controllers/bloc/language_bloc.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/constants/styles/paddings.dart';
import 'package:find_mosques/core/constants/styles/shapes.dart';
import 'package:find_mosques/core/constants/styles/text_styles.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:find_mosques/core/widgets/custom_header.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(title: locale.appLanguage),
          _buildBody(context, locale),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations locale,
  ) {
    return Container(
      height: context.screenHeight() * 0.7,
      padding: customPadding(30, 15),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LanguageCard(
                  title: locale.arabic,
                  image: "assets/icons/arabic.png",
                  languageCode: "ar",
                ),
                LanguageCard(
                  title: locale.english,
                  image: "assets/icons/english.png",
                  languageCode: "en",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Add your existing custom widget/context extension methods and other required imports here

class LanguageCard extends StatelessWidget {
  final String title;
  final String image;
  final String languageCode;

  const LanguageCard({
    Key? key,
    required this.title,
    required this.image,
    required this.languageCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LanguageBloc>(context);

    return StreamBuilder<String>(
      stream: bloc.languageCodeStream,
      initialData: bloc.languageCode,
      builder: (context, snapshot) {
        final isSelected = snapshot.data == languageCode;

        return GestureDetector(
          onTap: () {
            bloc.add(ChangeLanguageEvent(languageCode: languageCode));
          },
          child: Container(
            height: context.screenWidht() * 0.4,
            width: context.screenWidht() * 0.4,
            decoration: BoxDecoration(
              border: isSelected
                  ? null
                  : Border.all(width: 3, color: secondaryColor),
              color: isSelected ? secondaryColor : null,
              borderRadius: customBorderRadius(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: context.screenWidht() * 0.2,
                  width: context.screenWidht() * 0.2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover),
                    borderRadius: customBorderRadius(
                        radious: context.screenWidht() * 0.2),
                  ),
                ),
                Text(
                  title,
                  style: largeTitleTextStyle.copyWith(
                    color: isSelected ? Colors.white : secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
