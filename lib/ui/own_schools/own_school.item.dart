import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/ownschool.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/shared_preferences/shared_preferences_helper.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class OwnSchoolsItem extends StatefulWidget {
  final OwnSchool ownSchool;

  const OwnSchoolsItem({Key key, this.ownSchool}) : super(key: key);

  @override
  _OwnSchoolsItemState createState() => _OwnSchoolsItemState();
}

class _OwnSchoolsItemState extends State<OwnSchoolsItem> with ValidationMixin {
  bool _isLoading = false;

  bool isEdit = true;

  String _editeLevel;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("jjkjjkjkhkll");

    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () {
        print("asmaa");
        _authProvider.setOwnSchool(widget.ownSchool);
        print(_authProvider.ownSchool.id);
        SharedPreferencesHelper.saveSchool("school", _authProvider.ownSchool);

        Navigator.pushReplacementNamed(context, '/home_screen');
      },
      child: Card(
        child: Container(
          color: Colors.white,
          child: ListTile(
              title: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: FadeInImage(
                  image: NetworkImage('${widget.ownSchool.photopath}'),
                  placeholder: AssetImage("assets/images/logo.png"),
                ),
              ),
              Text(
                widget.ownSchool.name,
                style: TextStyle(color: mainAppColor, fontSize: 25),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
