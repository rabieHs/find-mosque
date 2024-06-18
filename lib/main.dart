import 'package:find_mosques/Features/home/presentation/controllers/bloc/home_bloc.dart';
import 'package:find_mosques/Features/landing/presentation/controllers/bloc/pager_bloc.dart';
import 'package:find_mosques/Features/language/presentation/controllers/bloc/language_bloc.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/mosque_bloc/mosque_bloc.dart';
import 'package:find_mosques/Features/prayer/presentation/controllers/bloc/prayer_bloc.dart';
import 'package:find_mosques/Features/splash/presentation/controllers/bloc/luanch_bloc.dart';
import 'package:find_mosques/Features/splash/presentation/views/luanch_screen.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/injection/dependecy_injection.dart';
import 'package:find_mosques/core/methods/maps_methods.dart';
import 'package:find_mosques/core/routes/routes.dart';
import 'package:find_mosques/firebase_options.dart';
import 'package:find_mosques/l10n/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  Locale locale = Locale('ar');

  @override
  Widget build(BuildContext context) {
    MapsMethos().getUserAddress();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<HomeBloc>()),
        BlocProvider(create: (context) => sl<MapsBloc>()),
        BlocProvider(
            create: (context) => sl<LuanchBloc>()..add(StartSplashEvent())),
        BlocProvider(create: (context) => sl<PagerBloc>()),
        BlocProvider(create: (context) => sl<MosqueBloc>()),
        BlocProvider(create: (context) => sl<PrayerBloc>()),
        BlocProvider(
            create: (context) => sl<LanguageBloc>()..add(GetLanguageEvent())),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              useMaterial3: true,
            ),
            supportedLocales: L10n.all,
            locale: state is LanguageLoaded
                ? Locale(state.languageCode)
                : BlocProvider.of<LanguageBloc>(context).languageCode.isEmpty
                    ? locale
                    : Locale(
                        BlocProvider.of<LanguageBloc>(context).languageCode),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            home: LuanchScreen(),
            routes: Routes.pagesRoutes,
          );
        },
      ),
    );
  }
}
