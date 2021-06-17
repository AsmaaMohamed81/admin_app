

import 'package:admin_app/ui/auth/login_screen.dart';
import 'package:admin_app/ui/auth/sign_up_screen.dart';
import 'package:admin_app/ui/education_classes/classes_screen.dart';
import 'package:admin_app/ui/education_classes/widgets/new_class.dart';
import 'package:admin_app/ui/home/home_screen.dart';
import 'package:admin_app/ui/intro/intro_screen.dart';
import 'package:admin_app/ui/levels/levels_screen.dart';
import 'package:admin_app/ui/own_schools/own_school_screen.dart';
import 'package:admin_app/ui/splash/splash_screen.dart';
import 'package:admin_app/ui/subjects/add_teacher.dart';
import 'package:admin_app/ui/subjects/list_teacher_screen.dart';
import 'package:admin_app/ui/subjects/new_subject.dart';
import 'package:admin_app/ui/subjects/selecte_teacher.dart';
import 'package:admin_app/ui/subjects/subjects_screen.dart';

final routes = {
  '/': (context) => SplashScreen(),
  '/level_screen': (context) => LevelsScreen(),
  '/home_screen': (context) => HomeScreen(),
  '/subjects_screen': (context) => SubjectsScreen(),

  '/login_screen': (context) => LoginScreen(),
  '/intro_screen': (context) => IntroScreen(),
  '/classes_screen': (context) => ClassesScreen(),
  '/sign_up_screen': (context) => SignUpScreen(),
  '/own_schools_screen': (context) => OwnSchoolsScreen(),
  '/new_class': (context) => NewClass(),
  '/new_subject': (context) => NewSubject(),
  '/add_taecher': (context) => AddTeacher(),
  '/select_teacher':(context)=> SelectTeacher(),
  '/list_teacher_screen':(context)=> ListTeacherScreen()

//   '/notifications_screen': (context) => NotificationsScreen(),
//   '/account_screen': (context) => AccountScreen(),
//   '/account_editing_screen': (context) => AccountEditingScreen(),
//   '/language_screen': (context) => LanguageScreen(),
};
