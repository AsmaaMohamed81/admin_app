import 'package:admin_app/bloc/classes_bloc/classes_bloc.dart';
import 'package:admin_app/bloc/levels_bloc/levels_bloc.dart';
import 'package:admin_app/bloc/years_bloc/years_bloc.dart';
import 'package:admin_app/custom_widget/app_drawer/app_drawer.dart';
import 'package:admin_app/custom_widget/dialogs/connectivity/network_indicator.dart';
import 'package:admin_app/custom_widget/drop_down_list_selector/drop_down_list_selector_object.dart';
import 'package:admin_app/custom_widget/safe_area/page_container.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/classes.dart';
import 'package:admin_app/data/model/level.dart';
import 'package:admin_app/data/model/years.dart';
import 'package:admin_app/data/repository/level.repository.dart';
import 'package:admin_app/data/repository/years.repository.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/ui/education_classes/arguments.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class NewSubject extends StatefulWidget {
  @override
  _NewSubjectState createState() => _NewSubjectState();
}

class _NewSubjectState extends State<NewSubject> with ValidationMixin {
  double _width = 0.0;

  AuthProvider _authProvider;

  ApiProvider _apiProvider = ApiProvider();
  bool isleaded = false;
  String _className = '';
  final _formKey = GlobalKey<FormState>();

  // Future<List<Semester>> _semesterList;
  // Future<List<Subjects>> _materialsList;

  List<Levels> _levelList;
  Levels _selectedLevel;
  List<Years> _yearsList;
  Years _selectedYears;
  // List<Subjects> materialList;
  // List<int> materialListId = [];

  int levelId, classId, materialId, yearId;
  bool _initialRun = true;
  bool check = true;
  var args;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments as Arguments;
    print("fdgdgfhh   ${args.valuer.toString()}");
    _authProvider = Provider.of<AuthProvider>(context);

    final appBar = AppBar(
      backgroundColor: mainAppColor,
      elevation: 0,
      leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Image.asset(
            'assets/images/menu.png',
            color: Colors.white,
          )),
      title: Text("Classes", style: Theme.of(context).textTheme.headline1),
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Stack(
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ])
            ],
          ),
        )
      ],
    );

    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: mainAppColor,
            ),
            child: AppDrawer(),
          ),
          key: _scaffoldKey,
          appBar: appBar,
          body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  color: greyAlert,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          args.valuer != 0 ? 'Edit Class' : 'Add New Class',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            child: Icon(
                              Icons.close,
                              size: 25,
                            ),
                            onTap: () => Navigator.pop(context),
                          ))
                    ],
                  ),
                ),
                Divider(
                  height: 5,
                  thickness: 1.2,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveBtn(BuildContext context) {
    return Container(
      height: 30,
      width: 75,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          print(_authProvider.currentUser.accessToken);
          print(args.valuer);
          print(_authProvider.ownSchool.id);
          print(_className.toString());
          print(levelId.toString());
          print(yearId);

          if (_formKey.currentState.validate()) {
            if (args.valuer != 0) {
              levelId = args.eductionclass.levelId;
              yearId = args.eductionclass.academicYearId;
              if (_className.isEmpty) {
                _className = args.eductionclass.materialName;
              }
            }

            context.read<ClassesBloc>().add(AddOrEditClasses(
                _authProvider.currentUser.accessToken,
                args.valuer,
                _authProvider.ownSchool.id,
                _className,
                levelId,
                yearId));
          }
          Navigator.pop(context);

          Navigator.pushNamed(context, '/classes_screen');
        },
        color: mainAppColor,
        child: Text(
          'Save',
          style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  _BuildEditDropDown(String name, BuildContext context) {
    // ignore: deprecated_member_use
    // ignore: missing_required_param
    // ignore: deprecated_member_use
    return FlatButton(
        onPressed: () {},
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: hintColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(color: hintColor),
              ),
            ],
          ),
        ));
  }
}
