import 'package:find_mosques/Features/splash/presentation/controllers/bloc/luanch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors/colors.dart';

class LuanchScreen extends StatelessWidget {
  const LuanchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LuanchBloc, LuanchState>(
      listener: (context, state) {
        if (state is LuanchLoaded) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("luanch success"),
                  ));
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
