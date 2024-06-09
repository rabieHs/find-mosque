import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/maps_widget.dart';
import '../widgets/prayer_time_widget.dart';
import '../widgets/search_field_widget.dart';

class FindMosque extends StatelessWidget {
  const FindMosque({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildHeader(context),
        _buildMapContainer(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: context.screenHeight() * 0.32,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrayerTimeWidget(locale: locale),
          SearchFieldWidget(locale: locale)
        ],
      ),
    );
  }

  Widget _buildMapContainer(BuildContext context) {
    return const Expanded(
      child: MapsWidget(),
    );
  }
}
