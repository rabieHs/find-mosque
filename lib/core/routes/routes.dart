import 'package:find_mosques/Features/home/presentation/views/pages/home.dart';
import 'package:find_mosques/Features/landing/presentation/views/landing_screen.dart';
import 'package:flutter/material.dart';

import '../../Features/splash/presentation/views/luanch_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> pagesRoutes = {
    "/luanch": (context) => const LuanchScreen(),
    "/landing": (context) => LandingScreen(),
    "/home": (context) => Home(),
  };
}
