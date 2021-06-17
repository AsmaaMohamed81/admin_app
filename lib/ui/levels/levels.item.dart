import 'package:admin_app/bloc/levels_bloc/levels_bloc.dart';
import 'package:admin_app/custom_widget/dialogs/log_out_dialog.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/level.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LevelsItem extends StatefulWidget {
  final Levels levels;

  const LevelsItem({Key key, this.levels}) : super(key: key);

  @override
  _LevelsItemState createState() => _LevelsItemState();
}

class _LevelsItemState extends State<LevelsItem> with ValidationMixin {
  AuthProvider _authProvider;

  bool isEdit = true;

  String _editeLevel;

  final _formkey = GlobalKey<FormState>();

  final nameHolder = TextEditingController();

  clearTextInput() {
    nameHolder.clear();
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return Card(
        child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: isEdit
              ? Text(
                  widget.levels.name,
                  style: TextStyle(color: mainAppColor, fontSize: 15),
                )
              : Form(
                  key: _formkey,
                  child: TextFormField(
                    onChanged: (value) {
                      _editeLevel = value;
                    },
                    initialValue: widget.levels.name,
                    validator: validatelevel,
                    decoration: InputDecoration(
                        errorMaxLines: 2,
                        suffixIcon: Container(
                          width: 50,
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
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
        ),
      ),
      secondaryActions: <Widget>[
        _buildEditIcon(),
        _buildDeleteIcon(),
      ],
    ));
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

  Widget _buildDeleteIcon() {
    return BlocListener<LevelsBloc, LevelsState>(
      listener: (context, state) {
        if (state is LevelsDeleted) {
          if (state.message['status'] == "Success") {
            _result(state.message);
          } else {
            Commons.showError(context, state.message["message"]);
          }
        }
      },
      child: BlocBuilder<LevelsBloc, LevelsState>(
        builder: (context, state) {
          LevelsBloc bloc = BlocProvider.of<LevelsBloc>(context);

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
                          "Are you sure you want to delete Level \"${widget.levels.name}\" , Do you want to continue?",
                      onPressedConfirm: () {
                        bloc.add(DeletLevels(
                            _authProvider.currentUser.accessToken,
                            widget.levels.id,
                            _authProvider.ownSchool.id));
                      },
                    );
                  });

              print(" ${Urls.Delete_Level}?Id=${widget.levels.id}");
            },
          );
        },
      ),
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
    return BlocBuilder<LevelsBloc, LevelsState>(
      builder: (context, state) {
        LevelsBloc bloc = BlocProvider.of<LevelsBloc>(context);
        return Container(
            child: InkWell(
          onTap: () async {
            if (_editeLevel == null) {
              _editeLevel = widget.levels.name;
            }
            if (_formkey.currentState.validate()) {
              bloc.add(AddOrEditLevels(_authProvider.currentUser.accessToken,
                  widget.levels.id, _authProvider.ownSchool.id, _editeLevel));
            }
          },
          child: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
        ));
      },
    );
  }
}
