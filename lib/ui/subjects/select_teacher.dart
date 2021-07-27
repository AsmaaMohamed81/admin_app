import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/bloc/teachers_bloc/teachers_bloc.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/demobottomappbar.dart';
import 'package:admin_app/custom_widget/no_data/no_data.dart';
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
  List<Teachers> _teachersList = [];
  List<Teachers> _searchResult = [];
  AuthProvider _authProvider;
  ArgumentsTeacherSubjects args;
  TextEditingController _searchController = TextEditingController();
  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.03),
          child: Container(
            decoration: BoxDecoration(
              color: searchcolor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              cursorColor: mainAppColor,
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                _searchResult.clear();

                if (text.isEmpty) {
                  setState(() {});
                  print("empty");
                  return;
                } else {
                  setState(() {
                    _teachersList.forEach((userDetail) {
                      if (userDetail.userName
                          .toLowerCase()
                          .contains(text.toLowerCase())) {
                        _searchResult.add(userDetail);
                      }
                    });
                  });
                }
              },
              onChanged: (text) {
                _searchResult.clear();

                if (text.isEmpty) {
                  setState(() {});
                  print("empty");
                  return;
                } else {
                  setState(() {
                    _teachersList.forEach((userDetail) {
                      if (userDetail.userName
                          .toLowerCase()
                          .contains(text.toLowerCase())) {
                        _searchResult.add(userDetail);
                      }
                    });
                  });
                }
              },
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: InputBorder.none,

                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                //   borderSide: BorderSide(color: Colors.white),

                // ),
                contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                prefixIcon: Icon(
                  Icons.search,
                  color: HexColor('212121'),
                  size: 17,
                ),
                hintText: "Search Subjects",
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<TeachersBloc, TeachersState>(
              builder: (context, state) {
            if (state is TeachersLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TeachersLoaded) {
              _teachersList = state.teachers;
              print("lenthhhhhhhhh${_teachersList.length.toString()}");

              if (_teachersList.length > 0) {
                for (int i = 0;
                    i < args.subjects.teacherToSubjects.length;
                    i++) {
                  print("iiiiii ${i.toString()}");
                  _teachersList.removeWhere((item) =>
                      item.id == args.subjects.teacherToSubjects[i].teacherId);
                }

                print(args.subjects.teacherToSubjects.length);

                return _teachersList.length > 0
                    ? _buildListSubjects(_teachersList)
                    : Center(
                        child: Text(
                        "All teachers have been added",
                        style: TextStyle(
                          fontSize: 20,
                          color: HexColor('B9C3D5'),
                        ),
                      ));
              } else {
                return Center(
                    child: Text(
                  "There are no teachers to display",
                  style: TextStyle(
                    fontSize: 20,
                    color: HexColor('B9C3D5'),
                  ),
                ));
              }
            } else if (state is TeachersError) {
              return Text(state.message.toString());
            }
            return Container();
          }),
        ),
      ],
    );
  }

  Widget _buildListSubjects(_teachersList) {
    return _teachersList.length > 0
        ? _searchResult.length != 0 || _searchController.text.isNotEmpty
            ? _searchResult.length == 0
                ? CustomText(
                    text: "  No records found",
                    color: mainAppColor,
                  )
                : ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SelecteTeacherItem(
                        subjects: args.subjects,
                        teacher: _searchResult[index],
                        indexi: index,
                      );
                    })
            : ListView.builder(
                itemCount: _teachersList.length,
                itemBuilder: (context, index) {
                  return SelecteTeacherItem(
                    subjects: args.subjects,
                    teacher: _teachersList[index],
                    indexi: index,
                  );
                },
              )
        : NoData(message: 'No Subject');
  }

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
                            context.read<SubjectsBloc>().add(
                                AddOrEditSubjectsSelect(
                                    _authProvider.currentUser.accessToken,
                                    args.subjects.id,
                                    _authProvider.ownSchool.id,
                                    args.subjects.name,
                                    args.subjects.abbreviation,
                                    SelecteTeacherItem.materialListId));
                            SelecteTeacherItem.materialListId = [];
                            Navigator.pushReplacementNamed(
                                context, '/subjects_screen');
                          }
                        },
                        child: CustomText(
                          text: "Add Teacher",
                          color: Colors.white,
                        ),
                      )))),
            ),
            body: _buildBody()));
  }
}
