import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/bloc/teachers_bloc/teachers_bloc.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/demobottomappbar.dart';
import 'package:admin_app/data/model/teachers.dart';
import 'package:admin_app/data/repository/teacher.repository.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/ui/subjects/arguments.teacher.dart';
import 'package:admin_app/ui/subjects/widget/selecte_teacher_item.dart';
import 'package:admin_app/utils/app_colors.dart';
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
  var args;

  Widget _buildSaveBtn(context) {
    return BlocBuilder<SubjectsBloc, SubjectsState>(
      builder: (context, state) {
        SubjectsBloc bloc = BlocProvider.of<SubjectsBloc>(context);

        return Container(
          height: 30,
          width: 75,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () async {
              print("in");

              // if (_formKey.currentState.validate()) {
              print("injjjjjjjjjj");

              bloc.add(AddOrEditSubjects(
                  _authProvider.currentUser.accessToken,
                  args.subjects.id,
                  _authProvider.ownSchool.id,
                  args.subjects.name,
                  args.subjects.abbreviation,
                  SelecteTeacherItem.materialListId));

              Navigator.of(context).pop();
              // }
            },
            color: floatbottom,
            child: Text(
              'Save',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments as ArgumentsTeacher;
    print("iiiiiiiiiiiiiid ${args.subjects.id.toString()}");

    _authProvider = Provider.of<AuthProvider>(context);

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

                          // if (_formKey.currentState.validate()) {
                          print("injjjjjjjjjj");

                          context.read<SubjectsBloc>().add(AddOrEditSubjects(
                              _authProvider.currentUser.accessToken,
                              args.subjects.id,
                              _authProvider.ownSchool.id,
                              args.subjects.name,
                              args.subjects.abbreviation,
                              SelecteTeacherItem.materialListId));

                          Navigator.of(context).pop();
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
                return ListView.builder(
                  itemCount: _teachersList.length,
                  itemBuilder: (context, index) {
                    return SelecteTeacherItem(
                      teacher: _teachersList[index],
                      Index: index,
                    );
                  },
                );
              } else if (state is TeachersError) {
                return Text(state.message.toString());
              }
              return Container();
            })));
  
  
  }
}
