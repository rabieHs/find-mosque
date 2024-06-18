import 'package:find_mosques/Features/landing/presentation/controllers/bloc/pager_bloc.dart';
import 'package:find_mosques/Features/splash/presentation/controllers/bloc/luanch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors/colors.dart';

class LuanchScreen extends StatelessWidget {
  const LuanchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PagerBloc>(context).add(GetLandingEvent());

    return BlocListener<LuanchBloc, LuanchState>(
      listener: (context, state) {
        if (state is LuanchLoaded) {
          if (BlocProvider.of<PagerBloc>(context).landingKey.isEmpty) {
            Navigator.pushNamed(context, "/landing");
          } else {
            Navigator.pushNamed(context, "/home");
          }
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: primaryColor.withOpacity(0.9),
          body: Center(
            child: Image.asset("assets/images/luanch_logo.png"),
          ),
        ),
      ),
    );
  }
}
