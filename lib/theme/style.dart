
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


ThemeData themeData() {
  return ThemeData(
      primaryColor: mainAppColor,
      hintColor: hintColor,
      brightness: Brightness.light,
      buttonColor: mainAppColor,
      scaffoldBackgroundColor: Color(0xffFFFFFF),
      fontFamily: 'IBMPlexSans',
      cursorColor: mainAppColor,
      textTheme: TextTheme(
        // app bar style
        headline1:
            TextStyle(  color: Colors.white,fontSize: 18, fontWeight: FontWeight.w400),

      
        headline2: TextStyle(
            fontFamily: 'IBMPlexSans',
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w800),

        // hint style of text form
        headline3: TextStyle(
                    color: hintColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),

      // style title Text (PopularComapnies)
        headline4: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            height: 1.5),
        
    // style title Text (Watch All)
        headline5: TextStyle(
          color: mainAppColor,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),

        button: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.0),

      
      ));
}

