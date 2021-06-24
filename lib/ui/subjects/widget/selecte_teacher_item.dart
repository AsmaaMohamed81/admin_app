import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/data/model/teachers.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';

class SelecteTeacherItem extends StatefulWidget {
  final Subjects subjects;
  final Teachers teacher;
  final int indexi;
  static List<int> materialListId = [];

  const SelecteTeacherItem({Key key, this.teacher, this.indexi, this.subjects})
      : super(key: key);

  @override
  _SelecteTeacherItemState createState() => _SelecteTeacherItemState();
}

class _SelecteTeacherItemState extends State<SelecteTeacherItem> {
  bool check = false;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.subjects.teacherToSubjects.length; i++) {
      if (widget.subjects.teacherToSubjects[i].teacherId == widget.teacher.id) {
        check = true;
        SelecteTeacherItem.materialListId.add(widget.teacher.id);
        print("${widget.subjects.teacherToSubjects[i].teacherName}");
      }
    }
    print("lenght teacher=${SelecteTeacherItem.materialListId.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(8),
      color: widget.indexi % 2 == 0 ? HexColor('F3F4FF') : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: HexColor('3034A5'),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(
                        widget.teacher.userPhoto == null
                            ? "https://nofiredrills.com/wp-content/uploads/2016/10/myavatar.png"
                            : widget.teacher.userPhoto,
                      )),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.teacher.userName.toString(),
                    style: TextStyle(
                      color: check ? HexColor('F98622') : HexColor('707070'),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.teacher.isClassRoomTeacher != null &&
                            widget.teacher.isClassRoomTeacher
                        ? "Teacher Room Class"
                        : " ",
                    style: TextStyle(
                      color: HexColor('B9C3D5'),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Transform.scale(
              scale: .9,
              child: Container(
                height: 23,
                width: 23,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: HexColor('CACEF6'))),
                child: Checkbox(
                    activeColor: Colors.transparent,
                    fillColor: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors
                            .transparent; // the color when checkbox is selected;
                      }
                      return Colors
                          .transparent; //the color when checkbox is unselected;
                    }),
                    checkColor: HexColor('F98622'),

                    // activeColor: Colors.white,
                    // checkColor: HexColor('F98622'),
                    value: check,
                    onChanged: (bool value) {
                      int materialID = widget.teacher.id;
                      print("id material check = ${widget.teacher.id}");

                      check = value;
                      print("vlaue$value check$check");

                      setState(() {
                        if (value) {
                          SelecteTeacherItem.materialListId.add(materialID);
                        } else {
                          SelecteTeacherItem.materialListId.remove(materialID);
                        }

                        // widget.teacher.isSelected = value;
                      });

                      print(SelecteTeacherItem.materialListId);
                    }),
              )),
        ],
      ),
    );
  }
}
