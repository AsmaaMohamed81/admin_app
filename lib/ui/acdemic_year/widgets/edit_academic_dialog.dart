import 'package:admin_app/bloc/academic_bloc/academic_bloc.dart';
import 'package:admin_app/bloc/classes_bloc/classes_bloc.dart';
import 'package:admin_app/bloc/levels_bloc/levels_bloc.dart';
import 'package:admin_app/bloc/semester_bloc/semester_bloc.dart';
import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/bloc/years_bloc/years_bloc.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/drop_down_list_selector/drop_down_list_selector_object.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/academic.dart';
import 'package:admin_app/data/model/classes.dart';
import 'package:admin_app/data/model/level.dart';
import 'package:admin_app/data/model/semester.dart';
import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/data/model/years.dart';
import 'package:admin_app/data/repository/years.repository.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/data/repository/level.repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class EditAcademicDialog extends StatefulWidget {
  final Academic academic;
  final int value;

  const EditAcademicDialog({Key key, this.academic, this.value})
      : super(key: key);

  @override
  _EditAcademicDialogState createState() => _EditAcademicDialogState();
}

class _EditAcademicDialogState extends State<EditAcademicDialog>
    with ValidationMixin {
  double _width = 0.0;

  AuthProvider _authProvider;

  ApiProvider _apiProvider = ApiProvider();
  bool isloeded = false;
  String _materialName, _abberviation;
  final _formKey = GlobalKey<FormState>();

  List<int> id = [];

  int levelId, classId, materialId, semesterCurrentId;
  bool ismatch = false;

  final nameHolder = TextEditingController();
  final nameHolder2 = TextEditingController();
  String _yearsname;
  bool checkyear = false;
  bool checksemester = false;
  bool ischeckyear = false;
  List<Semester> _semesterList;
  Semester _selsectsemster;
  int vali;

  clearTextInput() {
    nameHolder.clear();
    nameHolder2.clear();
    checkyear = false;
    checksemester = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkyear = widget.academic.isCurrentYear;
    // if (widget.subjects.teacherToSubjects.length > 0) {
    //   for (int i = 0; i < widget.subjects.teacherToSubjects.length; i++) {
    //     id.add(widget.subjects.teacherToSubjects[i].teacherId);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    // _width = MediaQuery.of(context).size.width;
    // print("ldksldlenghtttt=${widget.subjects.teacherToSubjects.length}");
    return AlertDialog(
        backgroundColor: HexColor('F2F7F9'),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
        actionsPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width * .7,
            child: new Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        _yearsname = value;
                      },
                      validator: validateAcademic,
                      decoration: InputDecoration(
                        errorMaxLines: 2,
                        errorStyle: TextStyle(fontSize: 9),
                        hintText: "Academic Year Name",
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                      initialValue:
                          widget.value == 0 ? "${widget.academic.name}" : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                            scale: .9,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: HexColor('B5C6D1'),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.transparent,
                                  fillColor:
                                      MaterialStateColor.resolveWith((states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Colors
                                          .transparent; // the color when checkbox is selected;
                                    }
                                    return Colors
                                        .transparent; //the color when checkbox is unselected;
                                  }),

                                  // activeColor: Colors.white,
                                  // checkColor: HexColor('F98622'),
                                  value: checkyear,
                                  onChanged: (bool value) {
                                    print("{checkyear1 $checkyear}");
                                    if (widget.academic.isCurrentYear == true) {
                                      Commons.showToast(
                                          context: context,
                                          message:
                                              " set the academic year as the current year",
                                          duration: 3,
                                          gravity: 1);
                                    } else {
                                      setState(() {
                                        //use that state here
                                        checkyear = value;

                                        print("{checkyear2 $checkyear}");
                                      });
                                    }
                                  }),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: "Current Year",
                          color: HexColor('83A7BE'),
                          fontSize: 14,
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    checkyear ? _buildDropDowenyears() : Container(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _buildSaveBtn(context),
                        SizedBox(width: 10),
                        Container(
                          height: 30,
                          width: 75,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              clearTextInput();
                            },
                            color: bluecancel,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: 'IBMPlexSans',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget _buildDropDowenyears() {
    _semesterList = widget.academic.semesters;
    var yearsListDropDown = _semesterList.map((Semester semester) {
      return new DropdownMenuItem<Semester>(
        value: semester,
        child: new Text(
          semester.name,
          style: new TextStyle(color: Colors.black),
        ),
      );
    }).toList();

    for (int i = 0; i < widget.academic.semesters.length; i++) {
      if (widget.academic.semesters[i].isCurrentSemester) {
        vali = i;
      }
    }
    return Container(
      height: 60,
      child: DropDownListSelectorObject(
        validatemessage: "Please Select Current Semester",
        hint: widget.academic.isCurrentYear
            ? "${widget.academic.name}"
            : "Select Current Semester",
        value: widget.academic.isCurrentYear
            ? widget.academic.semesters[vali]
            : _selsectsemster,
        onChangeFunc: (newValue) {
          setState(() {
            _selsectsemster = newValue;
            semesterCurrentId = _selsectsemster.id;
            print("semesterid = ${semesterCurrentId.toString()}");
          });
        },
        dropDownList: yearsListDropDown,
      ),
    );
  }

  Widget _buildSaveBtn(BuildContext context) {
    return Container(
      height: 30,
      width: 75,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          if (_yearsname == null) {
            _yearsname = widget.academic.name;
          }
          if (semesterCurrentId == null) {
            semesterCurrentId = widget.academic.semesters[vali].id;
          }
          print(_authProvider.currentUser.accessToken);
          print(widget.academic.id.toString());
          print(_yearsname.trim());
          print(checkyear);
          print(_authProvider.ownSchool.id.toString());
          print(semesterCurrentId.toString());
          if (_formKey.currentState.validate()) {
            CircularProgressIndicator();

            context.read<AcademicBloc>().add(EditAcademic(
                  _authProvider.currentUser.accessToken,
                  widget.academic.id,
                  _yearsname.trim(),
                  checkyear,
                  semesterCurrentId,
                  _authProvider.ownSchool.id,
                ));

            print("stattee");
          }
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
  }
}
