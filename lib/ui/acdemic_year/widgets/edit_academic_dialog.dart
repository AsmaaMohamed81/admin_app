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

  int levelId, classId, materialId, yearId;
  bool ismatch = false;

  final nameHolder = TextEditingController();
  final nameHolder2 = TextEditingController();
  String _yearsname, _semetername;
  bool checkyear = false;
  bool checksemester = false;
  bool checksemesteris = false;

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
    // if (widget.subjects.teacherToSubjects.length > 0) {
    //   for (int i = 0; i < widget.subjects.teacherToSubjects.length; i++) {
    //     id.add(widget.subjects.teacherToSubjects[i].teacherId);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    checkyear = widget.academic.isCurrentYear;

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
            height: MediaQuery.of(context).size.height * .15,
            width: MediaQuery.of(context).size.width * .7,
            child: new Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        _semetername = value;
                      },
                      validator: validateSemesteredit,
                      decoration: InputDecoration(
                        errorMaxLines: 2,
                        errorStyle: TextStyle(fontSize: 9),
                        hintText: "Academic Semester Year",
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                      initialValue:
                          widget.value == 0 ? "${widget.academic.name}" : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    checkyear
                        ? Row(
                            children: [
                              Transform.scale(
                                  scale: .9,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: HexColor('B5C6D1'),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.transparent,
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return Colors
                                                .transparent; // the color when checkbox is selected;
                                          }
                                          return Colors
                                              .transparent; //the color when checkbox is unselected;
                                        }),

                                        // activeColor: Colors.white,
                                        // checkColor: HexColor('F98622'),
                                        value: checksemesteris
                                            ? true
                                            : checksemester,
                                        onChanged: (bool value) {
                                          print("{$checksemester}");

                                          setState(() {
                                            if (checksemesteris) {
                                              Commons.showToast(
                                                  context: context,
                                                  message:
                                                      "The current semester cannot be modified",
                                                  duration: 3);
                                              checksemester = checksemesteris;
                                            } else {
                                              //use that state here
                                              checksemester = value;

                                              print("{$checksemester}");
                                            }
                                          });
                                        }),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                text: "Current Semeter",
                                color: HexColor('83A7BE'),
                                fontSize: 14,
                              )
                            ],
                          )
                        : Container(),
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

  Widget _buildSaveBtn(BuildContext context) {
    return Container(
      height: 30,
      width: 75,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            CircularProgressIndicator();

            if (_semetername == null) {
              _semetername = widget.academic.name;
            }

            context.read<SemesterBloc>().add(AddOrEditSemester(
                _authProvider.currentUser.accessToken,
                widget.academic.id,
                _semetername,
                _authProvider.ownSchool.id,
                widget.academic.id,
                checksemester));

            Navigator.of(context).pop();

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
