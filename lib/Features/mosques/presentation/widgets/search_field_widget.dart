import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String?)? onQueryChanged;
  final void Function()? onTap;
  const SearchFieldWidget({
    this.onQueryChanged,
    this.onTap,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return TextFormField(
      onTap: onTap,
      onChanged: onQueryChanged,
      controller: controller,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
          filled: true,
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  onPressed: () => controller!.clear(),
                  icon: const Icon(Icons.cancel, color: Colors.black),
                )
              : null,
          prefixIcon: IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/icons/search_icon.png",
                width: 23,
              )),
          hintText: locale.search,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none)),
    );
  }
}
