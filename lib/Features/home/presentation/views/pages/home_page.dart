// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            print("pressed");
            BlocProvider.of<HomeBloc>(context)
                .add(openDrawerEvent(languageCode: locale.languageCode));
          },
        ),
        title: Text('Home'),
      ),
    );
  }
}
