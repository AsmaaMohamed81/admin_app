import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarCustom {
  final String title;
  final GlobalKey<ScaffoldState> keyScafold;
  final Function backarrow;

  const AppBarCustom({this.title, this.keyScafold, this.backarrow});

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

  Widget AppBarRow() {
    return AppBar(
      centerTitle: true,

      backgroundColor: mainAppColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      )),
      leading: GestureDetector(
          onTap: backarrow,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 15),
            height: 30,
            width: 30,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          )),
      //  Image.asset(
      //   'assets/images/menu.png',
      //   color: Colors.white,
      // )),

      title: Text(
        title,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
      actions: <Widget>[
        // GestureDetector(
        //   // onTap: () => Navigator.pop(context),
        //   child: Stack(
        //     children: <Widget>[
        //       Column(children: <Widget>[
        //         Container(
        //           margin: EdgeInsets.only(left: 10, right: 10, top: 22),
        //           height: 25,
        //           width: 25,
        //           child: Icon(
        //             Icons.search,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ])
        //     ],
        //   ),
        // )
      ],
    );
  }
}
