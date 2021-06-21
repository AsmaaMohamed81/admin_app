import 'package:admin_app/custom_widget/demobottomappbar.dart';
import 'package:admin_app/ui/subjects/arguments.teacher.dart';
import 'package:admin_app/ui/subjects/arguments_techer_subjects.dart';
import 'package:admin_app/ui/subjects/widget/list_teacher_item.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ListTeacherScreen extends StatefulWidget {
  @override
  _ListTeacherScreenState createState() => _ListTeacherScreenState();
}

class _ListTeacherScreenState extends State<ListTeacherScreen> {
  ArgumentsTeacherSubjects args;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
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
          child: Text("Submit Teachers",
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
      body: ListView.builder(
        itemCount: args.teacherToSubjects.length,
        itemBuilder: (context, index) {
          return List_teacher_Item(
              teacherTosubjects: args.teacherToSubjects[index],
              subjects: args.subjects,
              delete: () {
                setState(() {
                  args.teacherToSubjects.removeAt(index);
                });
              },
              Index: index);
        },
      ),
      bottomNavigationBar: DemoBottomAppBar(),
      floatingActionButton: Container(
        height: 60.0,
        width: 60.0,
        padding: EdgeInsets.all(5),
        child: FloatingActionButton(
          backgroundColor: floatbottom,
          onPressed: () => Navigator.pushNamed(context, '/select_teacher',
              arguments: ArgumentsTeacherSubjects(
                  args.subjects.teacherToSubjects, null, args.subjects)),
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
