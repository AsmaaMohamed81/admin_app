import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/custom_widget/dialogs/log_out_dialog.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/ui/subjects/arguments/arguments.teacher.dart';
import 'package:admin_app/ui/subjects/arguments/arguments_techer_subjects.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class SubjectsItem extends StatefulWidget {
  final Subjects subjects;

  const SubjectsItem({Key key, this.subjects}) : super(key: key);

  @override
  _SubjectsItemState createState() => _SubjectsItemState();
}

class _SubjectsItemState extends State<SubjectsItem> with ValidationMixin {
  AuthProvider _authProvider;

  bool isEdit = true;

  String _editeSubjects, _editeabbrevation;
  List<TeacherToSubjects> listIdTeacher;
  List<int> id = [];

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        Slidable(
          actionPane:
              isEdit ? SlidableDrawerDismissal() : SlidableBehindActionPane(),
          actionExtentRatio: 0.12,
          child: Row(
            children: [
              Image.asset(
                "assets/images/materialll.png",
                width: 65,
              ),
              SizedBox(
                width: 10,
              ),
              isEdit
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Text(
                            widget.subjects.name,
                            style: TextStyle(
                                color: HexColor('707070'), fontSize: 16),
                          ),
                        ),
                        Text(
                          widget.subjects.abbreviation == null
                              ? " "
                              : "(${widget.subjects.abbreviation})",
                          style: TextStyle(
                              color: HexColor('9A9AA1'), fontSize: 10),
                        )
                      ],
                    )
                  : Expanded(
                      child: Form(
                        key: _formkey,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  TextFormField(
                                      onChanged: (value) {
                                        _editeSubjects = value;
                                      },
                                      initialValue: widget.subjects.name,
                                      validator: validateSubjects,
                                      decoration: InputDecoration(
                                        errorMaxLines: 2,
                                        errorStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .02),
                                      )),
                                  TextFormField(
                                      onChanged: (value) {
                                        _editeabbrevation = value;
                                      },
                                      initialValue:
                                          widget.subjects.abbreviation,
                                      validator: validateAbberviation,
                                      decoration: InputDecoration(
                                        errorMaxLines: 2,
                                        errorStyle: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .02),
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _buildCheckEditIcon(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isEdit = true;
                                      });
                                    },
                                    child: Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
          secondaryActions: <Widget>[
            _buildAddIcon(),
            _buildEditIcon(),
            _buildDeleteIcon(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Divider(
                  thickness: 2,
                )),
          ],
        )
      ],
    );
  }

  Widget _buildEditIcon() {
    return IconSlideAction(
      color: Colors.green,
      icon: Icons.edit,
      onTap: () {
        setState(() {
          isEdit = false;
        });
      },
    );
  }

  Widget _buildAddIcon() {
    return IconSlideAction(
      color: HexColor('88C0E3'),
      icon: Icons.person_add,
      foregroundColor: Colors.white,
      onTap: () {
        widget.subjects.teacherToSubjects.length == 0
            ? Navigator.pushNamed(
                context,
                '/add_taecher',
                arguments: ArgumentsTeacher(widget.subjects, null),
              )
            : Navigator.pushNamed(context, '/list_teacher_screen',
                arguments: ArgumentsTeacherSubjects(
                    widget.subjects.teacherToSubjects, null, widget.subjects));
      },
    );
  }

  Widget _buildDeleteIcon() {
    return IconSlideAction(
      color: Colors.red,
      icon: Icons.delete,
      onTap: () async {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) {
              return LogoutDialog(
                button1: "Yes",
                button2: "NO",
                alertMessage:
                    "Are you sure you want to delete Subject \"${widget.subjects.name}\" , Do you want to continue?",
                onPressedConfirm: () {
                  context.read<SubjectsBloc>().add(DeletSubjects(
                      _authProvider.currentUser.accessToken,
                      widget.subjects.id,
                      _authProvider.ownSchool.id));
                },
              );
            });

        print(" ${Urls.Delete_Subject}?Id=${widget.subjects.id}");
      },
    );
  }

  _result(Map<String, dynamic> results) {
    Commons.showToast(
      context: context,
      message: results["message"],
    );

    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget _buildCheckEditIcon() {
    return Container(
        child: InkWell(
      onTap: () {
        if (_editeSubjects == null) {
          _editeSubjects = widget.subjects.name;
        }
        if (_editeabbrevation == null) {
          _editeabbrevation = widget.subjects.abbreviation;
        }
        if (listIdTeacher == null) {
          listIdTeacher = widget.subjects.teacherToSubjects;

          for (int i = 0; i < widget.subjects.teacherToSubjects.length; i++) {
            id.add(widget.subjects.teacherToSubjects[i].teacherId);
          }
        }
        if (_formkey.currentState.validate()) {
          context.read<SubjectsBloc>().add(AddOrEditSubjects(
              _authProvider.currentUser.accessToken,
              widget.subjects.id,
              _authProvider.ownSchool.id,
              _editeSubjects,
              _editeabbrevation,
              id));
        }
      },
      child: Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 40,
      ),
    ));
  }
}
