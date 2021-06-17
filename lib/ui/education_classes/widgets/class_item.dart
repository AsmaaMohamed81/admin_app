import 'package:admin_app/bloc/classes_bloc/classes_bloc.dart';
import 'package:admin_app/bloc/levels_bloc/levels_bloc.dart';
import 'package:admin_app/custom_widget/dialogs/log_out_dialog.dart';
import 'package:admin_app/data/model/classes.dart';
import 'package:admin_app/data/model/user.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/ui/education_classes/arguments.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'adding_new_class_dialog.dart';
import 'new_class.dart';

class ClassItem extends StatefulWidget {
  final Classes classes;
  final int index;

  const ClassItem({Key key, this.classes, this.index}) : super(key: key);

  @override
  _ClassItemState createState() => _ClassItemState();
}

class _ClassItemState extends State<ClassItem> {
  User _currentUser;

  AuthProvider _authProvider;

  ApiProvider _apiProvider = ApiProvider();
  ClassesBloc bloc;

  Widget _buildPopupMenu(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return PopupMenuButton(
        child: Icon(
          Icons.more_vert,
          color: Color(0xffBBB6B6),
          size: 17,
        ),
        onSelected: (value) {
          switch (value) {
            case "Delete":
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) {
                    return LogoutDialog(
                      button1: "Yes",
                      button2: "NO",
                      alertMessage:
                          "Are you sure you want to delete Class \"${widget.classes.name}\" , Do you want to continue?",
                      onPressedConfirm: () {
                        context.read<ClassesBloc>().add(DeletClasses(
                            _authProvider.currentUser.accessToken,
                            widget.classes.id,
                            _authProvider.ownSchool.id));
                      },
                    );
                  });

              break;
            case 'Edit':
              Navigator.pushNamed(
                context,
                '/new_class',
                arguments: Arguments(widget.classes, widget.classes.id),
              );

              // showDialog(
              //     barrierDismissible: true,
              //     context: context,
              //     builder: (_) {
              //       return AddingNewClassDialog(
              //           eductionclass: widget.classes,
              //           value: widget.classes.id);
              //     });
              break;
          }
        },
        itemBuilder: (context) {
          // ignore: deprecated_member_use
          var menuList = List<PopupMenuEntry<Object>>();
          menuList.add(
            PopupMenuItem(
                value: 'Delete', height: 30, child: _buildDeleteIcon()),
          );
          menuList.add(
            PopupMenuDivider(
              height: 10,
            ),
          );
          menuList.add(
            PopupMenuItem(value: 'Edit', height: 30, child: _buildEditIcon()),
          );

          return menuList;
        });
  }

  Widget _buildEditIcon() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.edit,
            color: Colors.green,
          ),
        ),
        Text(
          "Edit",
          style: TextStyle(
              color: mainAppColor, fontWeight: FontWeight.w400, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildDeleteIcon() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        Text(
          "Delete",
          style: TextStyle(
              color: mainAppColor, fontWeight: FontWeight.w400, fontSize: 15),
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    final width = MediaQuery.of(context).size.width;

    return Card(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0.0, 15, 0.0),
                  child: Text(
                    '${widget.classes.academicYearName}',
                    style: TextStyle(
                        color: Color(0xff4A9AF5),
                        fontSize: width * .04,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                '${widget.classes.levelName} ',
                style: TextStyle(fontSize: width * .03, color: Colors.red),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    '${widget.classes.name}',
                    style: TextStyle(
                      fontSize: width * .04,
                      color: Color(0xff3E416D),
                    ),
                  )),
            ],
          ),
          Positioned(
            top: 5,
            right: 5,
            child: _buildPopupMenu(context),
          )
        ],
      ),
    );
  }
}
