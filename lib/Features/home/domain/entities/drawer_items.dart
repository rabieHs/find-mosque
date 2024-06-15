import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:find_mosques/Features/home/domain/entities/drawer_item.dart';

class DrawerItems extends Equatable {
  final AppLocalizations locale;

  const DrawerItems(this.locale);

  static const home = DrawerItem(title: 'Home', icon: Icons.home, id: 0);

  List<DrawerItem> getLocalizedItems() {
    return [
      DrawerItem(title: locale.home, icon: Icons.home, id: 0),
      DrawerItem(title: locale.myAccount, icon: Icons.heart_broken, id: 1),
      DrawerItem(title: locale.appLanguage, icon: Icons.message, id: 2),
      DrawerItem(title: locale.contactUs, icon: Icons.person, id: 3),
    ];
  }

  @override
  List<Object?> get props => [locale];
}
