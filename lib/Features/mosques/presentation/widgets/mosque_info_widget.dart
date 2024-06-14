import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles/text_styles.dart';
import '../../../../core/injection/dependecy_injection.dart';
import '../../../../core/widgets/circle_progress_button.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/mosque.dart';
import 'custom_info_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MosqueInfoWidget extends StatelessWidget {
  const MosqueInfoWidget(
      {super.key, required this.location, required this.mosque});

  final Location location;
  final Mosque mosque;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Column(
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
        _buildGender(),
        _buildRoute(context, locale),
        const Divider(),
        _buildInfos(locale),
        CircleProgressButton(
          pageProgress: 100,
          onTap: () {
            Navigator.pop(context);
            BlocProvider.of<MapsBloc>(context).add(StartNavigationEvent(
                lat: mosque.location.latitude,
                long: mosque.location.longitude));
          },
        )
      ],
    );
  }

  Row _buildInfos(AppLocalizations locale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomInfoWidget(
          icon: Icons.mosque,
          title: mosque.isAvailable ? locale.availableForPrayer : locale.none,
          subTitle: locale.mosqueStatus,
        ),
        CustomInfoWidget(
          icon: Icons.mosque,
          title:
              mosque.isFridayPrayer ? locale.availableForPrayer : locale.none,
          subTitle: locale.fridayPrayer,
        ),
        CustomInfoWidget(
          icon: Icons.mosque,
          title: mosque.isTeaching ? locale.thereIs : locale.none,
          subTitle: locale.lessonCircles,
        ),
      ],
    );
  }

  Widget _buildRoute(BuildContext context, AppLocalizations locale) {
    return BlocProvider(
      create: (context) => sl<MapsBloc>()
        ..add(GetRouteInfoEvent(
            lat: mosque.location.latitude, long: mosque.location.longitude)),
      child: BlocBuilder<MapsBloc, MapsState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomInfoWidget(
                    icon: Icons.location_pin,
                    title: locale.distance,
                    subTitle: state is SuccessGetRouteInfoState
                        ? "${state.distance} KM"
                        : "...",
                  ),
                  CustomInfoWidget(
                    icon: Icons.timer,
                    title: locale.estimatedTime,
                    subTitle: state is SuccessGetRouteInfoState
                        ? "${state.estimatedTime} Min"
                        : "...",
                  ),
                ],
              ),
              Text(
                state is SuccessGetRouteInfoState ? state.street : "...",
                style: defaultSubtitleTextStyle,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGender() {
    if (mosque.isManAndWomen) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/man.png"),
          const SizedBox(
            width: 5,
          ),
          Image.asset("assets/icons/women.png"),
        ],
      );
    } else {
      return Image.asset("assets/icons/man.png");
    }
  }
}
