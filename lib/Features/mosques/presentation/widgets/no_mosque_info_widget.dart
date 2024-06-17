import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/colors/colors.dart';
import '../../../../core/constants/styles/shapes.dart';
import '../../../../core/constants/styles/text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/location.dart';
import '../views/add_mosque_info.dart';

class NoMosqueInfoWidget extends StatelessWidget {
  const NoMosqueInfoWidget({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/icons/search_icon.png",
            width: 75,
            height: 75,
            scale: 1,
          ),
          Text(
            locale.noInformationAvailable,
            style: largeTitleTextStyle.copyWith(color: primaryColor),
          ),
          Text(
            locale.addInformation,
          ),
          CustomButton(
              title: locale.add,
              onPressed: () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                    shape: customRoundedShape(20),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SizedBox(
                        height: context.screenHeight() * 0.65,
                        child: AddMosqueInfo(
                          location: location,
                        )));
              }),
        ]);
  }
}
