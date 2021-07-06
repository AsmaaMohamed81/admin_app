import 'package:admin_app/ui/education_classes/arguments.dart';
import 'package:admin_app/ui/subjects/arguments/arguments.teacher.dart';
import 'package:admin_app/ui/subjects/arguments/arguments_techer_subjects.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';

class AddTeacher extends StatelessWidget {
  ArgumentsTeacher args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    print("iiiiiiiiiiiiiid ${args.subjects.id.toString()}");

    final appBar = AppBar(
      backgroundColor: mainAppColor,
      centerTitle: true,

      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      )),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.white,
        ),
      ),
      //  Image.asset(
      //   'assets/images/menu.png',
      //   color: Colors.white,
      // )),
      title: Text("Subject Teachers",
          style: Theme.of(context).textTheme.headline1),
      // actions: <Widget>[
      //   GestureDetector(
      //     onTap: () => Navigator.pop(context),
      //     child: Stack(
      //       children: <Widget>[
      //         Column(children: <Widget>[
      //           Container(
      //             margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      //             height: 30,
      //             width: 30,
      //             child: Icon(
      //               Icons.arrow_forward_ios,
      //               color: Colors.white,
      //             ),
      //           ),

      //         ])
      //       ],
      //     ),
      //   )
      // ],
    );

    return Scaffold(
        appBar: appBar,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/teacher_ban.png'),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No Teacher assigned to this subject ,please add first teacher',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HexColor('B9C3D5'),
                      fontSize: 16,
                    ),
                  )),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: floatbottom,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: GestureDetector(
                  child: Icon(
                    Icons.add,
                    color: white,
                    size: 40,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/select_teacher',
                        arguments: ArgumentsTeacherSubjects(
                            args.subjects.teacherToSubjects,
                            null,
                            args.subjects));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
