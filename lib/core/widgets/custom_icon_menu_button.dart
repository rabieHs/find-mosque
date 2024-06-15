import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Features/home/presentation/controllers/bloc/home_bloc.dart';

class CustomIconMenuButton extends StatelessWidget {
  const CustomIconMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          BlocProvider.of<HomeBloc>(context).add(openDrawerEvent(
              languageCode: Localizations.localeOf(context).languageCode));
        },
        child: const Icon(
          Icons.menu,
          size: 30,
          color: Colors.white,
        ));
  }
}
