import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
    required this.locale,
  });

  final AppLocalizations? locale;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
          filled: true,
          prefixIcon: IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/icons/search_icon.png",
                width: 23,
              )),
          hintText: locale!.search,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none)),
    );
  }
}
