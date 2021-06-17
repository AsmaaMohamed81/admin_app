import 'dart:io';
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';





class PageContainer extends StatelessWidget {
  final Widget child;
  const PageContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Platform.isIOS ? Colors.white : mainAppColor,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus( FocusNode());
            },
            child: child,
          ),
        ));
  }
}
