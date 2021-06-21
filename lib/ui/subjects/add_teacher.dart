import 'package:admin_app/ui/education_classes/arguments.dart';
import 'package:admin_app/ui/subjects/arguments.teacher.dart';
import 'package:admin_app/ui/subjects/arguments_techer_subjects.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AddTeacher extends StatelessWidget {
  ArgumentsTeacher args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    print("iiiiiiiiiiiiiid ${args.subjects.id.toString()}");

    final appBar = AppBar(
      backgroundColor: mainAppColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      )),
      leading: GestureDetector(
          // onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Container()),
      //  Image.asset(
      //   'assets/images/menu.png',
      //   color: Colors.white,
      // )),
      title: Center(
          child: Text("Subject Teachers",
              style: Theme.of(context).textTheme.headline1)),
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Stack(
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ])
            ],
          ),
        )
      ],
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
                    'No Teacher assigned to this subject ,please add first teacher'),
              ),
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
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/select_teacher',
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
