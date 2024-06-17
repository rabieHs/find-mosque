import 'package:find_mosques/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/location.dart';
import '../controllers/mosque_bloc/mosque_bloc.dart';
import '../../../../core/constants/colors/colors.dart';
import '../../../../core/constants/styles/text_styles.dart';

class MosquesErrorWidget extends StatelessWidget {
  const MosquesErrorWidget({
    Key? key,
    required this.location,
    required this.locale,
  }) : super(key: key);

  final Location location;
  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/error.png"),
        Text(
          textAlign: TextAlign.center,
          locale.errorOccurredCheckInternet,
          style: largeTitleTextStyle.copyWith(color: primaryColor),
        ),
        CustomButton(
          title: locale.retry,
          onPressed: () {
            BlocProvider.of<MosqueBloc>(context)
                .add(GetMosqueInfoEvent(location: location, context: context));
          },
        ),
      ],
    );
  }
}
