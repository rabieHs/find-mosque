// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/mosque_bloc/mosque_bloc.dart';
import 'package:find_mosques/Features/mosques/presentation/views/add_mosque_info.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/constants/styles/paddings.dart';
import 'package:find_mosques/core/constants/styles/shapes.dart';
import 'package:find_mosques/core/constants/styles/text_styles.dart';
import 'package:find_mosques/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/mosque_info_widget.dart';

class MosqueInfo extends StatelessWidget {
  final Location location;
  const MosqueInfo({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<MosqueBloc, MosqueState>(
      builder: (context, state) {
        print(state.runtimeType);
        return SizedBox(
          width: double.infinity,
          height: state is SuccessGetMosqueState
              ? context.screenHeight() * 0.6
              : context.screenHeight() * 0.4,
          child: state is SuccessGetMosqueState
              ? _buildMosqueInfoContainer(state.mosque)
              : state is ErrorGetMosqueState
                  ? _buildErrorInfoContainer(context, locale)
                  : state is LoadingGetMosqueInfoState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _buildAddMosqueInfoContainer(context),
        );
      },
    );
  }

  Widget _buildErrorInfoContainer(
      BuildContext context, AppLocalizations locale) {
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

  Widget _buildAddMosqueInfoContainer(BuildContext context) {
    return NoMosqueInfoWidget(location: location);
  }

  Widget _buildMosqueInfoContainer(Mosque mosque) {
    return MosqueInfoWidget(
      location: location,
      mosque: mosque,
    );
  }
}

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
