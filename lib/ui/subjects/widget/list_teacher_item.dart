import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';

class List_teacher_Item extends StatefulWidget {
  final TeacherToSubjects subjects;
  final int Index;

  const List_teacher_Item({Key key, this.subjects, this.Index})
      : super(key: key);

  @override
  _List_teacher_ItemState createState() => _List_teacher_ItemState();
}

class _List_teacher_ItemState extends State<List_teacher_Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(widget.subjects.teacherName),
            ],
          ),
        ],
      ),
    );
  }
}
