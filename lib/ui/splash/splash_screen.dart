import 'package:admin_app/data/model/ownschool.dart';
import 'package:admin_app/data/model/user.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/shared_preferences/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _height = 0, _width = 0;
  AuthProvider _authProvider;

  Future initData() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<Null> _checkIsLogin() async {
    var userData = await SharedPreferencesHelper.read("user");
    var ownschoolData = await SharedPreferencesHelper.read("school");

    if (userData != null && ownschoolData != null) {
      _authProvider.setCurrentUser(User.fromJson(userData));
      _authProvider.setOwnSchool(OwnSchool.fromJson(ownschoolData));

      print(_authProvider.currentUser.email);
      Navigator.pushReplacementNamed(context, '/home_screen');
    } else {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  Future<Null> _checkIsFirstTime() async {
    var _firstTime = await SharedPreferencesHelper.checkIsFirstTime();
    if (_firstTime) {
      SharedPreferencesHelper.setIsFirstTime(false);
      Navigator.pushReplacementNamed(context, '/intro_screen');
    } else {
      _checkIsLogin();
    }
  }

  Widget _buildBodyItem() {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        height: 300,
      ),
    );
  }

  Future<void> _getLanguage() async {
    String currentLang = await SharedPreferencesHelper.getUserLang();
    _authProvider.setCurrentLanguage(currentLang);
  }

  @override
  void initState() {
    super.initState();
    initData().then((value) {
      _getLanguage();
      _checkIsFirstTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _buildBodyItem(),
    );
  }
}
