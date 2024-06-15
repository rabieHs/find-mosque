// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/drawer_item.dart';
import '../../../domain/entities/drawer_items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerWidget extends StatelessWidget {
  final ValueChanged<int> onSelectedItem;
  const DrawerWidget({
    Key? key,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final DrawerItems drawerItems = DrawerItems(locale);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: context.screenHeight() * 0.18,
              child: Center(
                child: ListTile(
                  leading: const CircleAvatar(),
                  title: Text(locale.helloWorld),
                  subtitle: Text(locale.aboutApp),
                ),
              )),
          _buildDrawerItems(context, drawerItems),
        ],
      ),
    );
  }

  Widget _buildDrawerItems(BuildContext context, DrawerItems drawerItems) {
    return Column(
        children: drawerItems.getLocalizedItems().map((item) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          item.title,
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          item.icon,
          color: Colors.white,
        ),
        onTap: () => onSelectedItem(item.id),
      );
    }).toList());
  }
}
