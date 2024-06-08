// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:find_mosques/Features/landing/presentation/controllers/bloc/pager_bloc.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';

import '../widgets/circle_progress_button.dart';
import '../widgets/page_view_widget.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  PageController controller = PageController();

  double pageProgress = 25;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PagerBloc, PagerState>(
      listener: (context, state) {
        if (state is ChangePageState) {
          pageProgress = state.progress;
          controller.jumpToPage(
            state.index,
          );
        }
        if (state is NavigatePageState) {
          Navigator.pushNamed(context, "/luanch");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(context),
        );
      },
    );
  }

  Column _buildBody(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(
          height: context.screenHeight() * 0.8,
          child: PageView(
            controller: controller,
            children: [
              PageViewWidget(
                  locale: locale,
                  image: "assets/images/0.png",
                  title: locale.nearestMosque),
              PageViewWidget(
                  locale: locale,
                  image: "assets/images/2.png",
                  title: locale.catchFridayPrayer),
              PageViewWidget(
                  locale: locale,
                  image: "assets/images/3.png",
                  title: locale.ladiesPrayerArea),
              PageViewWidget(
                  locale: locale,
                  image: "assets/images/4.png",
                  title: locale.dontMissCongregationalPrayer),
            ],
          ),
        ),
        _navigationControl(context)
      ],
    );
  }

  SizedBox _navigationControl(BuildContext context) {
    return SizedBox(
      height: context.screenHeight() * 0.2,
      child: Center(
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<PagerBloc>(context).add(NavigateToPageEvent(
                page: controller.page!, progress: pageProgress + 1));
          },
          child: CircleProgressButton(pageProgress: pageProgress),
        ),
      ),
    );
  }
}
