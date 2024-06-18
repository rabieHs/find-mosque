import 'package:find_mosques/Features/home/presentation/controllers/bloc/home_bloc.dart';
import 'package:find_mosques/Features/home/domain/entities/drawer_items.dart';
import 'package:find_mosques/Features/language/presentation/views/language.dart';
import 'package:find_mosques/Features/prayer/presentation/views/prayer.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../mosques/presentation/views/find_mosque.dart';
import '../../../domain/entities/drawer_item.dart';
import '../widgets/drawer_widget.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final DrawerItem selectedItem = DrawerItems.home;

  final bool dragging = false;

  final double xOffset = 0;

  final double yOffset = 0;

  final double scaleFoctor = 1;

  final List<Widget> screens = [FindMosque(), PrayerScreen(), LanguageScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(gradient: gradientColo),
          child: Scaffold(
            backgroundColor: secondaryColor.withOpacity(0.6),
            body: Stack(children: [
              _buildDrawer(context),
              _buildShadowPage(state, context),
              _buildPage(state, context)
            ]),
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return SafeArea(child: DrawerWidget(
      onSelectedItem: (id) {
        BlocProvider.of<HomeBloc>(context).add(ChangePageEvent(itemId: id));
      },
    ));
  }

  Widget _buildPage(HomeState state, BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (pop) async {
        if (BlocProvider.of<HomeBloc>(context).isDrowerOpen && pop == false) {
          BlocProvider.of<HomeBloc>(context).add(closeDrawerEvent());
        }
      },
      child: GestureDetector(
        onTap: () => BlocProvider.of<HomeBloc>(context).add(closeDrawerEvent()),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(
              state is DrawerOpenedState
                  ? state.xOffset
                  : state is DrawerClosedstate
                      ? state.xOffset
                      : xOffset,
              state is DrawerOpenedState
                  ? state.yOffset
                  : state is DrawerClosedstate
                      ? state.yOffset
                      : yOffset,
              0)
            ..scale(
                state is DrawerOpenedState ? state.scaleFoctor : scaleFoctor),
          child: AbsorbPointer(
              absorbing: BlocProvider.of<HomeBloc>(context).isDrowerOpen,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    BlocProvider.of<HomeBloc>(context).isDrowerOpen ? 20 : 0),
                child: screens[BlocProvider.of<HomeBloc>(context).page],
              )),
        ),
      ),
    );
  }

  Widget _buildShadowPage(HomeState state, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      transform: Matrix4.translationValues(
          state is DrawerOpenedState
              ? state.shoadowxOffset
              : state is DrawerClosedstate
                  ? state.xOffset
                  : xOffset,
          state is DrawerOpenedState
              ? state.shoadowyOffset
              : state is DrawerClosedstate
                  ? state.yOffset
                  : yOffset,
          0)
        ..scale(state is DrawerOpenedState
            ? state.shoadowscaleFoctor
            : scaleFoctor),
      child: AbsorbPointer(
          absorbing: BlocProvider.of<HomeBloc>(context).isDrowerOpen,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                BlocProvider.of<HomeBloc>(context).isDrowerOpen ? 20 : 0),
            child: Scaffold(
              backgroundColor: Colors.white.withOpacity(0.5),
            ),
          )),
    );
  }
}
