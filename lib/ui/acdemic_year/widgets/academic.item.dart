import 'package:admin_app/bloc/academic_bloc/academic_bloc.dart';
import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/custom_widget/dialogs/log_out_dialog.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/academic.dart';
import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/ui/acdemic_year/arguments/arguments_academic.dart';
import 'package:admin_app/ui/acdemic_year/widgets/edit_academic_dialog.dart';
import 'package:admin_app/ui/subjects/arguments/arguments.teacher.dart';
import 'package:admin_app/ui/subjects/arguments/arguments_techer_subjects.dart';
import 'package:admin_app/ui/subjects/widget/adding_new_class_dialog.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AcademicItem extends StatefulWidget {
  final int Index;
  final Academic academic;
  final List<Academic> listAcademic;

  const AcademicItem({Key key, this.academic, this.listAcademic, this.Index})
      : super(key: key);

  @override
  _AcademicItemState createState() => _AcademicItemState();
}

class _AcademicItemState extends State<AcademicItem> with ValidationMixin {
  AuthProvider _authProvider;

  bool isEdit = true;

  String _editeSubjects, _editeabbrevation;
  List<TeacherToSubjects> listIdTeacher;
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

    var d = context.read<SubjectsBloc>().state;
    print("stattedsjdjsde====${d}");
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
              widget.academic.name,
              style: TextStyle(color: HexColor('140A31'), fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            widget.academic.isCurrentYear
                ? Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: HexColor('F98622'),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      "Current Year",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))
                : Container()
          ],
        ),
        secondaryActions: <Widget>[
          _buildAddIcon(),
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
              return EditAcademicDialog(
                academic: widget.academic,
                value: 0,
              );
            });
      },
    );
  }

  Widget _buildAddIcon() {
    return IconSlideAction(
      color: HexColor('88C0E3'),
      icon: Icons.calendar_today_sharp,
      foregroundColor: Colors.white,
      onTap: () {
        Navigator.pushNamed(
          context,
          '/semester_screen',
          arguments: ArgumentsAcademic(widget.academic),
        );
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
                    "Are you sure you want to delete Academic Year \"${widget.academic.name}\" , Do you want to continue?",
                onPressedConfirm: () {
                  context.read<AcademicBloc>().add(DeletAcademic(
                      _authProvider.currentUser.accessToken,
                      widget.academic.id,
                      _authProvider.ownSchool.id));
                },
              );
            });

        print(" ${Urls.Delete_Subject}?Id=${widget.academic.id}");
      },
    );
  }

  Widget _buildCheckEditIcon() {
    return Container(
        child: InkWell(
      onTap: () {
        if (_editeSubjects == null) {
          _editeSubjects = widget.academic.name;
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
          context.read<SubjectsBloc>().add(AddOrEditSubjects(
              _authProvider.currentUser.accessToken,
              widget.academic.id,
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
