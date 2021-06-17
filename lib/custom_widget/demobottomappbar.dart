import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DemoBottomAppBar extends StatelessWidget {
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: mainAppColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.person_outline),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.insert_drive_file_rounded),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30.0,
              padding: EdgeInsets.only(right: 28.0),
              icon: Icon(Icons.list),
              onPressed: () {},
            )
          ],
        ),

        //  Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     IconButton(
        //       tooltip: 'home',
        //       icon: const Icon(Icons.home),
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //       tooltip: 'person',
        //       icon: const Icon(Icons.person_outline),
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //       tooltip: 'notifications',
        //       icon: const Icon(Icons.notifications),
        //       onPressed: () {},
        //     ),
        //     IconButton(
        //       tooltip: 'decument',
        //       icon: const Icon(Icons.insert_drive_file_rounded),
        //       onPressed: () {},
        //     ),
        //   ],
        // ),
      ),
    );
 
 
  }
}
