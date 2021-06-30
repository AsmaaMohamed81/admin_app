import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/bloc/teachers_bloc/teachers_bloc.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/demobottomappbar.dart';
import 'package:admin_app/data/model/teachers.dart';
import 'package:admin_app/data/repository/teacher.repository.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/ui/subjects/arguments/arguments.teacher.dart';
import 'package:admin_app/ui/subjects/arguments/arguments_techer_subjects.dart';
import 'package:admin_app/ui/subjects/widget/selecte_teacher_item.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SelectTeacher extends StatefulWidget {
  @override
  _SelectTeacherState createState() => _SelectTeacherState();
}

class _SelectTeacherState extends State<SelectTeacher> {
  List<Teachers> _teachersList;
  AuthProvider _authProvider;
  ArgumentsTeacherSubjects args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    print("iiiiiiiiiiiiiid ${args.subjects.id.toString()}");

    _authProvider = Provider.of<AuthProvider>(context);

    final appBar = AppBar(
      centerTitle: true,

      backgroundColor: mainAppColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      )),
      leading: GestureDetector(
          onTap: () => Navigator.pop(context),
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
      title:
          Text("Submit Teachers", style: Theme.of(context).textTheme.headline1),
      actions: <Widget>[
        GestureDetector(
          child: Stack(
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 22),
                  height: 25,
                  width: 25,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ])
            ],
          ),
        )
      ],
    );

    return BlocProvider(
        create: (context) => TeachersBloc(TeachersRepositoryImp())
          ..add(FetchTeachers(_authProvider.ownSchool.id)),
        child: Scaffold(
            appBar: appBar,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              color: mainAppColor,
              child: IconTheme(
                  data: IconThemeData(
                      color: Theme.of(context).colorScheme.onPrimary),
                  child: Container(
                      height: 50,
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          print(
                              "ggdgd lenghts= ${SelecteTeacherItem.materialListId} id = ${args.subjects.id} ${args.subjects.abbreviation}${args.subjects.name}");
                          print("in");

                          if (SelecteTeacherItem.materialListId.length == 0) {
                            Commons.showToast(
                                context: context,
                                message: "there are no changes to be saved ",
                                duration: 3);
                          } else {
                            print("injjjjjjjjjj");
                            for (int i = 0;
                                i < args.subjects.teacherToSubjects.length;
                                i++) {
                              SelecteTeacherItem.materialListId.add(
                                  args.subjects.teacherToSubjects[i].teacherId);
                            }
                            context.read<SubjectsBloc>().add(AddOrEditSubjects(
                                _authProvider.currentUser.accessToken,
                                args.subjects.id,
                                _authProvider.ownSchool.id,
                                args.subjects.name,
                                args.subjects.abbreviation,
                                SelecteTeacherItem.materialListId));
                            SelecteTeacherItem.materialListId = [];
                            Navigator.pushNamed(context, '/subjects_screen');
                          }
                        },
                        child: CustomText(
                          text: "Add Teacher",
                          color: Colors.white,
                        ),
                      )))),
            ),
            body: BlocBuilder<TeachersBloc, TeachersState>(
                builder: (context, state) {
              if (state is TeachersLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TeachersLoaded) {
                _teachersList = state.teachers;
                print(_teachersList.length.toString());

                for (int i = 0;
                    i < args.subjects.teacherToSubjects.length;
                    i++) {
                  print("iiiiii ${i.toString()}");
                  _teachersList.removeWhere((item) =>
                      item.id == args.subjects.teacherToSubjects[i].teacherId);
                }
                return _teachersList.length > 0
                    ? ListView.builder(
                        itemCount: _teachersList.length,
                        itemBuilder: (context, index) {
                          return SelecteTeacherItem(
                            subjects: args.subjects,
                            teacher: _teachersList[index],
                            indexi: index,
                          );
                        },
                      )
                    : Center(
                        child: Text(
                        "There are no teachers yet",
                        style: TextStyle(
                          fontSize: 20,
                          color: HexColor('B9C3D5'),
                        ),
                      ));
              } else if (state is TeachersError) {
                return Text(state.message.toString());
              }
              return Container();
            })));
  }
}
