// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/core/methods/loading.dart';
import 'package:find_mosques/core/methods/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:find_mosques/Features/mosques/presentation/controllers/mosque_bloc/mosque_bloc.dart';
import 'package:find_mosques/Features/mosques/presentation/widgets/custom_info_widget.dart';
import 'package:find_mosques/Features/mosques/presentation/widgets/custom_selection_widget.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/constants/styles/text_styles.dart';
import 'package:find_mosques/core/widgets/custom_text_field.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/location.dart';

class AddMosqueInfo extends StatelessWidget {
  final Location location;
  const AddMosqueInfo({
    Key? key,
    required this.location,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final ValueNotifier<bool?> fridayPrayer = ValueNotifier<bool?>(null);
    final ValueNotifier<bool?> ladiesPrayer = ValueNotifier<bool?>(null);
    final ValueNotifier<bool?> lessonCircles = ValueNotifier<bool?>(null);
    final ValueNotifier<bool?> mosqueStatus = ValueNotifier<bool?>(null);
    final nameController = TextEditingController();

    return BlocListener<MosqueBloc, MosqueState>(
      listener: (context, state) {
        if (state is LoadingAddMosqueState) {
          showLoadingDialog(context);
        }
        if (state is ErrorAddMosqueState) {
          Navigator.pop(context);
          showErrorMessage(context, state.message);
        }
        if (state is SuccessAddMosqueState) {
          Navigator.pop(context);
          showSuccessMessage(context, locale.mosqueAddedSuccessfully);
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SafeArea(
                    child: CustomTextField(
                        controller: nameController, hintText: location.name),
                  ),
                  CustomSelectionWidget(
                    question: locale.fridayPrayer,
                    value1: locale.availableForPrayer,
                    value2: locale.none,
                    selectedOptionNotifier: fridayPrayer,
                  ),
                  CustomSelectionWidget(
                    question: locale.ladiesPrayerArea,
                    value1: locale.thereIs,
                    value2: locale.none,
                    selectedOptionNotifier: ladiesPrayer,
                  ),
                  CustomSelectionWidget(
                    question: locale.lessonCircles,
                    value1: locale.thereIs,
                    value2: locale.none,
                    selectedOptionNotifier: lessonCircles,
                  ),
                  CustomSelectionWidget(
                    question: locale.mosqueStatus,
                    value1: locale.availableForPrayer,
                    value2: locale.none,
                    selectedOptionNotifier: mosqueStatus,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(context);

                      BlocProvider.of<MosqueBloc>(context).add(
                          AddMosqueInfoEvent(
                              nameController.text,
                              location,
                              ladiesPrayer.value!,
                              fridayPrayer.value!,
                              mosqueStatus.value!,
                              lessonCircles.value!));
                    },
                    title: locale.add,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
