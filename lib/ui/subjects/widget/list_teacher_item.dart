import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/custom_widget/dialogs/log_out_dialog.dart';
import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class List_teacher_Item extends StatefulWidget {
  final TeacherToSubjects teacherTosubjects;
  final Subjects subjects;
  final Function delete;
  final int Index;

  const List_teacher_Item(
      {Key key, this.subjects, this.Index, this.teacherTosubjects, this.delete})
      : super(key: key);

  @override
  _List_teacher_ItemState createState() => _List_teacher_ItemState();
}

class _List_teacher_ItemState extends State<List_teacher_Item> {
  AuthProvider _authProvider;
  List<int> id = [];

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.12,
      child: Container(
        height: 70,
        padding: EdgeInsets.all(8),
        color: widget.Index % 2 == 0 ? HexColor('F3F4FF') : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: HexColor('3034A5'),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                            "https://nofiredrills.com/wp-content/uploads/2016/10/myavatar.png")),
                  ),
                ),
                Text(widget.teacherTosubjects.teacherName),
              ],
            ),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        _buildDeleteIcon(),
      ],
    );
  }

  Widget _buildDeleteIcon() {
    return IconSlideAction(
      color: Colors.red,
      icon: Icons.delete,
      onTap: () async {
        id.clear();
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) {
              return LogoutDialog(
                button1: "Yes",
                button2: "NO",
                alertMessage:
                    "Are you sure you want to delete the teacher \"${widget.teacherTosubjects.teacherName}\" , Do you want to continue?",
                onPressedConfirm: () {
                  for (int i = 0;
                      i < widget.subjects.teacherToSubjects.length;
                      i++) {
                    id.add(widget.subjects.teacherToSubjects[i].teacherId);
                    id.remove(widget.teacherTosubjects.teacherId);
                  }
                  print("${id}");

                  context.read<SubjectsBloc>().add(AddOrEditSubjects(
                      _authProvider.currentUser.accessToken,
                      widget.subjects.id,
                      _authProvider.ownSchool.id,
                      widget.subjects.name,
                      widget.subjects.abbreviation,
                      id));
                  widget.delete();
                },
              );
            });
      },
    );
  }
}
