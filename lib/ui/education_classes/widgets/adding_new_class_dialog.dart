import 'package:admin_app/bloc/classes_bloc/classes_bloc.dart';
import 'package:admin_app/bloc/levels_bloc/levels_bloc.dart';
import 'package:admin_app/bloc/years_bloc/years_bloc.dart';
import 'package:admin_app/custom_widget/drop_down_list_selector/drop_down_list_selector_object.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/classes.dart';
import 'package:admin_app/data/model/level.dart';
import 'package:admin_app/data/model/years.dart';
import 'package:admin_app/data/repository/years.repository.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/data/repository/level.repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class AddingNewClassDialog extends StatefulWidget {
  final Classes eductionclass;
  final int value;

  AddingNewClassDialog({this.eductionclass, this.value});

  @override
  _AddingNewClassDialogState createState() => _AddingNewClassDialogState();
}

class _AddingNewClassDialogState extends State<AddingNewClassDialog>
    with ValidationMixin {
  double _width = 0.0;

  AuthProvider _authProvider;

  ApiProvider _apiProvider = ApiProvider();
  bool isloeded = false;
  String _className = '';
  final _formKey = GlobalKey<FormState>();

  // Future<List<Semester>> _semesterList;
  // Future<List<Subjects>> _materialsList;

  List<Levels> _levelList;
  Levels _selectedLevel;
  List<Years> _yearsList;
  Years _selectedYears;
  // List<Subjects> materialList;
  // List<int> materialListId = [];

  int levelId, classId, materialId, yearId;
  bool _initialRun = true;
  bool check = true;

  // Subjects _selectedMaterials;
  // Semester _selectedSemester;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 50, 0.0, 0.0),
        child: AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          actionsOverflowButtonSpacing: 10,
          actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          content: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  color: greyAlert,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.value != 0 ? 'Edit Class' : 'Add New Class',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            child: Icon(
                              Icons.close,
                              size: 25,
                            ),
                            onTap: () => Navigator.pop(context),
                          ))
                    ],
                  ),
                ),
                Divider(
                  height: 5,
                  thickness: 1.2,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10,
                ),
                widget.value != 0
                    ? _BuildEditDropDown(
                        widget.eductionclass.academicYearName, context)
                    : _buildDropDowenyears(),
                SizedBox(
                  height: 10,
                ),
                widget.value != 0
                    ? _BuildEditDropDown(
                        widget.eductionclass.levelName, context)
                    : _buildDropDowenLevels(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03),
                  child: TextFormField(
                    initialValue: widget.value != 0
                        ? "${widget.eductionclass.name}"
                        : null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                      hintText: widget.value != 0 ? " " : "Class Name",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: grey),
                      ),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 8),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: grey),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: grey),
                      ),
                    ),
                    onChanged: (text) {
                      _className = text;
                    },
                    validator: validateClass,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildSaveBtn(context),
                SizedBox(width: 2),
                Container(
                  height: 30,
                  width: 75,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () => Navigator.of(context).pop(),
                    color: grey,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'IBMPlexSans',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 7),
              ],
            ),
          
          
          
          ],
        ),
      ),
    );
  }

  Widget _buildDropDowenyears() {
    return Container(
      height: 60,
      child: BlocProvider(
        create: (context) => YearsBloc(YearsRepositoryImp())
          ..add(FetchYears(_authProvider.ownSchool.id)),
        child: BlocBuilder<YearsBloc, YearsState>(builder: (context, state) {
          if (state is YearsLoading) {
            return Container();
          } else if (state is YearsLoaded) {
            _yearsList = state.years;

            var yearsListDropDown = _yearsList.map((Years years) {
              return new DropdownMenuItem<Years>(
                value: years,
                child: new Text(
                  years.name,
                  style: new TextStyle(color: Colors.black),
                ),
              );
            }).toList();

            return Container(
              child: DropDownListSelectorObject(
                validatemessage: "Please Select Academic Year",
                hint: widget.value != 0
                    ? "${widget.eductionclass.academicYearName}"
                    : "Choose Academic Years",
                value: _selectedYears,
                onChangeFunc: (newValue) {
                  setState(() {
                    _selectedYears = newValue;
                    yearId = _selectedYears.id;
                    print("semesterid = ${yearId.toString()}");
                  });
                },
                dropDownList: yearsListDropDown,
              ),
            );
          } else if (state is YearsError) {
            return Text(state.message);
          } else {
            return Container(child: Text("NOOOOOOOO"));
          }
        }),
      ),
    );
  }

  Widget _buildDropDowenLevels() {
    return Container(
      height: 60,
      child: BlocProvider(
        create: (context) => LevelsBloc(LevelsRepositoryImp())
          ..add(FetchLevels(_authProvider.ownSchool.id)),
        child: BlocBuilder<LevelsBloc, LevelsState>(builder: (context, state) {
          if (state is LevelLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LevelLoaded) {
            _levelList = state.levels;

            var semesterListDropDown = _levelList.map((Levels semester) {
              return new DropdownMenuItem<Levels>(
                value: semester,
                child: new Text(
                  semester.name,
                  style: new TextStyle(color: Colors.black),
                ),
              );
            }).toList();

            return Container(
              child: DropDownListSelectorObject(
                validatemessage: "Please Select Level",
                hint: widget.value != 0
                    ? "${widget.eductionclass.academicYearName}"
                    : "Choose Level ",
                value: _selectedLevel,
                onChangeFunc: (newValue) {
                  setState(() {
                    _selectedLevel = newValue;
                    levelId = _selectedLevel.id;
                    print("semesterid = ${levelId.toString()}");
                  });
                },
                dropDownList: semesterListDropDown,
              ),
            );
          } else if (state is LevelError) {
            return Text("sorry");
          } else {
            return Container(child: Text("NOOOOOOOO"));
          }
        }),
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
          print(_authProvider.currentUser.accessToken);
          print(widget.value);
          print(_authProvider.ownSchool.id);
          print(_className.toString());
          print(levelId.toString());
          print(yearId);

          if (_formKey.currentState.validate()) {
            if (widget.value != 0) {
              levelId = widget.eductionclass.levelId;
              yearId = widget.eductionclass.academicYearId;
              if (_className.isEmpty) {
                _className = widget.eductionclass.name;
              }
            }

            context.read<ClassesBloc>().add(AddOrEditClasses(
                _authProvider.currentUser.accessToken,
                widget.value,
                _authProvider.ownSchool.id,
                _className,
                levelId,
                yearId));
            Navigator.of(context).pop(true);
          }
        },
        color: mainAppColor,
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

  _BuildEditDropDown(String name, BuildContext context) {
    return FlatButton(
        child: Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: hintColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(color: hintColor),
          ),
        ],
      ),
    ));
  }

  _result(Map<String, dynamic> results) {
    Commons.showToast(
      context: context,
      message: results["message"],
    );
    Navigator.of(context).pop(true);
  }
}
