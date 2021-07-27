import 'package:admin_app/bloc/academic_bloc/academic_bloc.dart';
import 'package:admin_app/bloc/levels_bloc/levels_bloc.dart';
import 'package:admin_app/bloc/semester_bloc/semester_bloc.dart';
import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/bloc/years_bloc/years_bloc.dart';
import 'package:admin_app/data/repository/Semester_repository.dart';
import 'package:admin_app/data/repository/academic_repository.dart';
import 'package:admin_app/data/repository/level.repository.dart';
import 'package:admin_app/bloc/classes_bloc/classes_bloc.dart';
import 'package:admin_app/data/repository/classes.repository.dart';
import 'package:admin_app/data/repository/subjects.repository.dart';
import 'package:admin_app/data/repository/years.repository.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/provider/navigation_provider.dart';
import 'package:admin_app/theme/style.dart';
import 'package:admin_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'locale/app_localizations.dart';
import 'locale/locale_helper.dart';
import 'shared_preferences/shared_preferences_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    run();
  });
}

void run() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  onLocaleChange(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Future<void> _getLanguage() async {
    String language = await SharedPreferencesHelper.getUserLang();
    onLocaleChange(Locale(language));
  }

  @override
  void initState() {
    super.initState();

    helper.onLocaleChanged = onLocaleChange;
    _locale = new Locale('en');
    _getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider<LevelsBloc>(
            create: (context) => LevelsBloc(
              LevelsRepositoryImp(),
            ),
            child: Container(),
          ),
          BlocProvider<ClassesBloc>(
            create: (context) => ClassesBloc(
              ClassesRepositoryImp(),
            ),
            child: Container(),
          ),
          BlocProvider<YearsBloc>(
            create: (context) => YearsBloc(
              YearsRepositoryImp(),
            ),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => SubjectsBloc(SubjectsRepositoryImp()),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => AcademicBloc(AcademicRepositoryImp()),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => SemesterBloc(SemesterRepositoryImp()),
            child: Container(),
          ),
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ],
        child: MaterialApp(
          locale: _locale,

          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          title: 'School App',
          theme: themeData(),
          // home: EducationalClassesScreen(),

          routes: routes,
        ));
  }
}
