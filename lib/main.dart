import 'package:find_mosques/Features/landing/presentation/controllers/bloc/pager_bloc.dart';
import 'package:find_mosques/Features/landing/presentation/views/landing_screen.dart';
import 'package:find_mosques/Features/mosques/presentation/views/find_mosque.dart';
import 'package:find_mosques/Features/splash/presentation/controllers/bloc/luanch_bloc.dart';
import 'package:find_mosques/Features/splash/presentation/views/luanch_screen.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/injection/dependecy_injection.dart';
import 'package:find_mosques/core/routes/routes.dart';
import 'package:find_mosques/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl<LuanchBloc>()..add(StartSplashEvent())),
        BlocProvider(create: (context) => sl<PagerBloc>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        supportedLocales: L10n.all,
        locale: const Locale('ar'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        home: const FindMosque(),
        routes: Routes.pagesRoutes,
      ),
    );
  }
}
