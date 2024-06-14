// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:find_mosques/Features/mosques/domain/entities/suggestion.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import 'package:find_mosques/Features/mosques/presentation/widgets/search_field_widget.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/constants/styles/paddings.dart';
import 'package:find_mosques/core/constants/styles/shapes.dart';
import 'package:find_mosques/core/constants/styles/text_styles.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:find_mosques/core/methods/messages.dart';

import '../../../../core/widgets/empty_data_widget.dart';
import 'search_result_card_widget.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocConsumer<MapsBloc, MapsState>(
      listener: (context, state) {
        if (state is ErrorSuggestionsState) {
          showErrorMessage(context, state.message);
        }
        if (state is SuccessMovingCameraToSearchedPlaceState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: primaryColor.withOpacity(0.1),
          body: Padding(
            padding: customPadding(20, 15),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAppBar(context, locale),
                _buildSearchField(state, context),
                _buildSearchResult(state, locale, context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResult(
      MapsState state, AppLocalizations locale, BuildContext context) {
    if (state is LoadedSuggestionsState) {
      return Container(
        margin: customPadding(10, 0),
        decoration: BoxDecoration(
            borderRadius: customBorderRadius, color: Colors.white),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: state.suggestions.length,
            itemBuilder: (context, index) {
              return SearchResultCard(
                suggestion: state.suggestions[index],
              );
            }),
      );
    } else if (state is EmptySuggestionsState) {
      return const EmptyDataWidget();
    } else {
      return Container();
    }
  }

  SafeArea _buildSearchField(state, BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: SearchFieldWidget(
        controller: searchController,
        onQueryChanged: (query) {
          BlocProvider.of<MapsBloc>(context)
              .add(GetPlacesSugegstionEvent(query: query!, context: context));
        },
      ),
    );
  }

  SizedBox _buildAppBar(BuildContext context, AppLocalizations locale) {
    return SizedBox(
      height: context.screenHeight() * 0.1,
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                size: 30,
              )),
          Padding(
            padding: customPadding(0, 20),
            child: Text(
              locale.searchTitle,
              style: largeTitleTextStyle.copyWith(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
