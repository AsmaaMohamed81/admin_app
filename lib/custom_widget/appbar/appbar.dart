import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarCustom {
  final String title;
  final GlobalKey<ScaffoldState> keyScafold;

  const AppBarCustom({this.title, this.keyScafold});

  Widget appBarCustom() {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainAppColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      )),
      leading: GestureDetector(
          onTap: () => keyScafold.currentState.openDrawer(),
          child: Icon(
            Icons.menu,
            color: Colors.white,
          )),
      title: Text(
        title,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }
}
