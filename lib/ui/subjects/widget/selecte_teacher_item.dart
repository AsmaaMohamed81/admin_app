import 'package:admin_app/data/model/teachers.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';

class SelecteTeacherItem extends StatefulWidget {
  final Teachers teacher;
  final int Index;
  static List<int> materialListId = [];

  const SelecteTeacherItem({Key key, this.teacher, this.Index})
      : super(key: key);

  @override
  _SelecteTeacherItemState createState() => _SelecteTeacherItemState();
}

class _SelecteTeacherItemState extends State<SelecteTeacherItem> {
  int selectedRadio;
  bool check = true;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    SelecteTeacherItem.materialListId.clear();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

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
                        widget.teacher.userPhoto.isEmpty
                            ? "https://nofiredrills.com/wp-content/uploads/2016/10/myavatar.png"
                            : widget.teacher.userPhoto,
                      )),
                ),
              ),
              Text(widget.teacher.userName.toString()),
            ],
          ),
          Transform.scale(
              scale: .9,
              child: Checkbox(
                  value: widget.teacher.isSelected,
                  onChanged: (bool value) {
                    widget.teacher.isSelected = false;
                    int materialID = widget.teacher.id;
                    print("id material check = ${widget.teacher.id}");
                    // materialListId
                    //     .add(materialList[index].id);
                    widget.teacher.isSelected = value;
                    // print("ccccc${materialListId[0].toString()}");
                    print("vlaue$value");

                    setState(() {
                      if (value) {
                        check = true;
                        SelecteTeacherItem.materialListId.add(materialID);
                      } else {
                        SelecteTeacherItem.materialListId.remove(materialID);
                      }

                      widget.teacher.isSelected = value;
                    });
                  })),
        ],
      ),
    );
  
  }
}
