import 'package:admin_app/bloc/classes_bloc/classes_bloc.dart';
import 'package:admin_app/bloc/levels_bloc/levels_bloc.dart';
import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/bloc/years_bloc/years_bloc.dart';
import 'package:admin_app/custom_widget/drop_down_list_selector/drop_down_list_selector_object.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/classes.dart';
import 'package:admin_app/data/model/level.dart';
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

class AddingNewClassDialog extends StatefulWidget {
  final Subjects subjects;
  final int value;
  final List<Subjects> subjectsList;

  const AddingNewClassDialog(
      {Key key, this.subjects, this.value, this.subjectsList})
      : super(key: key);

  @override
  _AddingNewClassDialogState createState() => _AddingNewClassDialogState();
}

class _AddingNewClassDialogState extends State<AddingNewClassDialog>
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.subjects.teacherToSubjects.length > 0) {
      for (int i = 0; i < widget.subjects.teacherToSubjects.length; i++) {
        id.add(widget.subjects.teacherToSubjects[i].teacherId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    _width = MediaQuery.of(context).size.width;
    print("ldksldlenghtttt=${widget.subjects.teacherToSubjects.length}");
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: HexColor('F2F7F9'),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          actionsPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
            width: MediaQuery.of(context).size.width * .7,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue:
                        widget.value == 0 ? "${widget.subjects.name}" : null,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      errorStyle: TextStyle(fontSize: 9),
                      hintText: "Subject Name",
                      hintStyle: TextStyle(fontSize: 10),
                    ),
                    onChanged: (text) {
                      _materialName = text;
                    },
                    validator: validateSubjects,
                  ),
                  TextFormField(
                    initialValue: widget.value == 0
                        ? "${widget.subjects.abbreviation}"
                        : null,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      errorStyle: TextStyle(fontSize: 9),
                      hintText: "Abbreviation",
                      hintStyle: TextStyle(fontSize: 10),
                    ),
                    onChanged: (text) {
                      _abberviation = text;
                    },
                    validator: validateAbberviation,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      // clearTextInput();
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
    );
  }

  Widget _buildSaveBtn(BuildContext context) {
    return Container(
      height: 30,
      width: 75,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            // valueu = 0;

            // widget.subjectsList.forEach((userDetail) {
            //   if (userDetail.name
            //           .toLowerCase()
            //           .contains(_materialName.toLowerCase()) ||
            //       userDetail.abbreviation
            //           .toLowerCase()
            //           .contains(_abberviation.toLowerCase())) {
            //     print("yesss");

            //     ismatch = true;
            //   }
            // });
            CircularProgressIndicator();

            if (_materialName == null) {
              _materialName = widget.subjects.name;
            }
            if (_abberviation == null) {
              _abberviation = widget.subjects.abbreviation;
            }

            context.read<SubjectsBloc>().add(AddOrEditSubjectsEdite(
                _authProvider.currentUser.accessToken,
                widget.subjects.id,
                _authProvider.ownSchool.id,
                _materialName,
                _abberviation,
                id));

            // Navigator.of(context).pop();

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
