// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/Features/mosques/presentation/widgets/mosques_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/mosque_bloc/mosque_bloc.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';

import '../widgets/mosque_info_widget.dart';
import '../widgets/no_mosque_info_widget.dart';

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
    return MosquesErrorWidget(
      location: location,
      locale: locale,
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
