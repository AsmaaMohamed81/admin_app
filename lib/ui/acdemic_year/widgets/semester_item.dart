import 'package:admin_app/bloc/semester_bloc/semester_bloc.dart';
import 'package:admin_app/custom_widget/dialogs/log_out_dialog.dart';
import 'package:admin_app/data/model/semester.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/ui/acdemic_year/widgets/edit_semester_dialog.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SemeterItem extends StatefulWidget {
  final int Index;
  final Semester semester;

  const SemeterItem({Key key, this.Index, this.semester}) : super(key: key);

  @override
  _SemeterItemState createState() => _SemeterItemState();
}

class _SemeterItemState extends State<SemeterItem> {
  AuthProvider _authProvider;

  bool isEdit = true;

  String _editeSubjects, _editeabbrevation;
  List<int> id = [];

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final stateA = context.read<SubjectsBloc>().state;
    // if (stateA is SubjectsAddOrEdite) {
    //   print("esgjdgsgdjkjwkjklsd");
    //   Navigator.of(context).pop();

    //   if (stateA.results['status'] == "Success") {
    //     Navigator.of(context).pop();
    //   }
    // }

    _authProvider = Provider.of<AuthProvider>(context);
    return Container(
      height: 80,
      padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
      color: widget.Index % 2 == 0 ? HexColor('FBFBFB') : Colors.white,
      child: Slidable(
        actionPane:
            isEdit ? SlidableDrawerDismissal() : SlidableBehindActionPane(),
        actionExtentRatio: 0.12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.semester.name != null ? widget.semester.name : "",
              style: TextStyle(color: HexColor('140A31'), fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            widget.semester.isCurrentSemester
                ? Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: HexColor('F98622'),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      "Current Semester",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))
                : Container()
          ],
        ),
        secondaryActions: <Widget>[
          _buildEditIcon(),
          _buildDeleteIcon(),
        ],
      ),
    );
  }

  Widget _buildEditIcon() {
    return IconSlideAction(
      color: Colors.green,
      icon: Icons.edit,
      onTap: () {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) {
              return EditSemesterDialog(
                semester: widget.semester,
                value: 0,
              );
            });
      },
    );
  }

  Widget _buildDeleteIcon() {
    return IconSlideAction(
      color: Colors.red,
      icon: Icons.delete,
      onTap: () async {
        print(widget.semester.id);
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) {
              return LogoutDialog(
                button1: "Yes",
                button2: "NO",
                alertMessage:
                    "Are you sure you want to delete semester \"${widget.semester.name}\" , Do you want to continue?",
                onPressedConfirm: () {
                  if (widget.semester.isCurrentSemester) {
                    Commons.showToast(
                        context: context,
                        message: "The current semester cannot be deleted",
                        duration: 3);
                  } else {
                    print(widget.semester.id);

                    context.read<SemesterBloc>().add(DeletSemester(
                        _authProvider.currentUser.accessToken,
                        widget.semester.id,
                        _authProvider.ownSchool.id,
                        widget.semester.academicYearId));
                  }
                },
              );
            });
      },
    );
  }

  Widget _buildCheckEditIcon() {
    return Container(
        child: InkWell(
      onTap: () {
        if (_editeSubjects == null) {
          _editeSubjects = widget.semester.name;
        }
        // if (_editeabbrevation == null) {
        //   _editeabbrevation = widget.academic.abbreviation;
        // }
        // if (listIdTeacher == null) {
        //   listIdTeacher = widget.academic.teacherToSubjects;

        //   for (int i = 0; i < widget.academic.teacherToSubjects.length; i++) {
        //     id.add(widget.academic.teacherToSubjects[i].teacherId);
        //   }
        // }
        if (_formkey.currentState.validate()) {
          // context.read<SemesterBloc>().add(AddOrEditSemester(
          //     _authProvider.currentUser.accessToken,
          //     widget.academic.id,
          //     _authProvider.ownSchool.id,
          //     _editeSubjects,
          //     _editeabbrevation,
          //     id));
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
