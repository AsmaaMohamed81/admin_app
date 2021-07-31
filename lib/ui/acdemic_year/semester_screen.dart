import 'package:admin_app/bloc/semester_bloc/semester_bloc.dart';
import 'package:admin_app/data/model/semester.dart';
import 'package:admin_app/ui/acdemic_year/arguments/arguments_academic.dart';
import 'package:admin_app/ui/acdemic_year/widgets/semester_item.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/bloc/academic_bloc/academic_bloc.dart';
import 'package:admin_app/custom_widget/app_drawer/app_drawer.dart';
import 'package:admin_app/custom_widget/appbar/appbar.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/demobottomappbar.dart';
import 'package:admin_app/custom_widget/dialogs/connectivity/network_indicator.dart';
import 'package:admin_app/custom_widget/no_data/no_data.dart';
import 'package:admin_app/custom_widget/safe_area/page_container.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/academic.dart';
import 'package:admin_app/ui/acdemic_year/widgets/academic.item.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:toast/toast.dart';

class SemesterScreen extends StatefulWidget {
  @override
  _SemesterScreenState createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> with ValidationMixin {
  AppBarCustom _appBarCustom;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Semester> _searchResult = [];
  List<Semester> _semesterList = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();
  bool checkyear = false;
  bool checksemester = false;
  AuthProvider _authProvider;
  String _yearsname, _semetername;
  int valueu;
  var args;

  final nameHolder = TextEditingController();
  final nameHolder2 = TextEditingController();

  clearTextInput() {
    nameHolder.clear();
    nameHolder2.clear();
    checkyear = false;
    checksemester = false;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args = ModalRoute.of(context).settings.arguments as ArgumentsAcademic;
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<SemesterBloc>()..add(FetchSemester(args.academic.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    checkyear = args.academic.isCurrentYear;
    _authProvider = Provider.of<AuthProvider>(context);

    _appBarCustom = AppBarCustom(
        title: "${args.academic.name} Semesters",
        keyScafold: _scaffoldKey,
        backarrow: () {
          Navigator.of(context).pop();
        });

    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: mainAppColor,
            ),
            child: AppDrawer(),
          ),
          key: _scaffoldKey,
          appBar: _appBarCustom.AppBarRow(),
          bottomNavigationBar: DemoBottomAppBar(),
          floatingActionButton: Container(
            height: 60.0,
            width: 60.0,
            padding: EdgeInsets.all(5),
            child: Commons.isKeyboardHidden(context)
                ? FloatingActionButton(
                    backgroundColor: floatbottom,
                    onPressed: () {
                      _settingModalBottomSheet(context);
                    },
                    tooltip: 'Increment Counter',
                    child: const Icon(Icons.add),
                  )
                : Container(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          body: _buildBodyItem(),
          resizeToAvoidBottomInset: true,
        ),
      ),
    );
  }

  _buildBodyItem() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.03),
          child: Container(
            decoration: BoxDecoration(
              color: searchcolor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              cursorColor: mainAppColor,
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                // textSearch = text;
                _searchResult.clear();

                if (text.isEmpty) {
                  setState(() {});
                  print("empty");
                  return;
                } else {
                  setState(() {
                    print("text");

                    _semesterList.forEach((userDetail) {
                      if (userDetail.name
                          .toLowerCase()
                          .contains(text.toLowerCase())) {
                        _searchResult.add(userDetail);
                      }
                    });
                  });
                }
              },
              onChanged: (text) {
                _searchResult.clear();

                if (text.isEmpty) {
                  setState(() {});
                  print("empty");
                  return;
                } else {
                  setState(() {
                    _semesterList.forEach((userDetail) {
                      if (userDetail.name
                          .toLowerCase()
                          .contains(text.toLowerCase())) {
                        _searchResult.add(userDetail);
                      }
                    });
                  });
                }
              },
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: InputBorder.none,

                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                //   borderSide: BorderSide(color: Colors.white),

                // ),
                contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                prefixIcon: Icon(
                  Icons.search,
                  color: HexColor('212121'),
                  size: 17,
                ),
                hintText: "Search Semester Name",
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocConsumer<SemesterBloc, SemesterState>(
            listener: (context, state) {
              if (state is SemesterAddOrEdite) {
                if (state.results['status'] == "Success") {
                  _result(state.results);
                } else if (state.results['status'] == "Unauthorized") {
                  Commons.showError(context, state.results["message"], () {
                    Navigator.pushReplacementNamed(context, '/login_screen');
                  });
                } else {
                  print("bootom sheet re open");

                  print("nonoononononon");
                  Commons.showError(
                      context, "This semester is already in this year", () {
                    if (valueu == 0) {
                      _settingModalBottomSheet(context);
                      valueu = null;
                    }
                  });
                }
              } else if (state is SemesterAddOrEditeEdite) {
                if (state.results['status'] == "Success") {
                  Navigator.of(context).pop();
                  _result(state.results);
                } else {
                  Commons.showError(
                      context, "This semester is already in this year", () {});
                }
              } else if (state is SemesterDeleted) {
                if (state.message['status'] == "Success") {
                  _result(state.message);
                } else {
                  Commons.showError(context, state.message["message"], () {});
                }
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is SemesterLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SemesterLoaded) {
                _semesterList = state.semester;

                // if (_searchResult.length > 0) {
                //   _searchResult.clear();
                //   _academicList.forEach((userDetail) {
                //     if (userDetail.name
                //             .toLowerCase()
                //             .contains(textSearch.toLowerCase()) ||
                //         userDetail.abbreviation
                //             .toLowerCase()
                //             .contains(textSearch.toLowerCase())) {
                //       _searchResult.add(userDetail);
                //     }
                //   });
                // }

                return _buildListAcademic(_semesterList);
              } else if (state is SemesterError) {
                return Text(state.message.toString());
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSaveBtn(BuildContext context) {
    return Container(
      height: 30,
      width: 75,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          print("in");

          if (_formKey.currentState.validate()) {
            print("_authProvider.ownSchool.id=${_authProvider.ownSchool.id}");
            print(
                "_authProvider.currentUser.accessToken${_authProvider.currentUser.accessToken}");
            valueu = 0;

            context.read<SemesterBloc>().add(AddOrEditSemester(
                _authProvider.currentUser.accessToken,
                0,
                _semetername.trim(),
                _authProvider.ownSchool.id,
                args.academic.id,
                checksemester));

            Navigator.of(context).pop();
            // clearTextInput();
          }
        },
        color: floatbottom,
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

  _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: new Container(
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 10),
                  height: 200,
                  decoration: new BoxDecoration(
                      color: HexColor('F2F7F9'),
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0))),
                  child: new Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameHolder2,
                            onChanged: (value) {
                              _semetername = value;
                            },
                            validator: validateSemesteredit,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              errorStyle: TextStyle(fontSize: 9),
                              hintText: "Academic Semester Name",
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          checkyear
                              ? Row(
                                  children: [
                                    Transform.scale(
                                        scale: .9,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: HexColor('B5C6D1'),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Checkbox(
                                              checkColor: Colors.white,
                                              activeColor: Colors.transparent,
                                              fillColor: MaterialStateColor
                                                  .resolveWith((states) {
                                                if (states.contains(
                                                    MaterialState.selected)) {
                                                  return Colors
                                                      .transparent; // the color when checkbox is selected;
                                                }
                                                return Colors
                                                    .transparent; //the color when checkbox is unselected;
                                              }),

                                              // activeColor: Colors.white,
                                              // checkColor: HexColor('F98622'),
                                              value: checksemester,
                                              onChanged: (bool value) {
                                                state(() {
                                                  //use that state here
                                                  checksemester = value;
                                                });
                                              }),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                      text: "Current Semeter",
                                      color: HexColor('83A7BE'),
                                      fontSize: 14,
                                    )
                                  ],
                                )
                              : Container(),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _buildSaveBtn(context),
                              SizedBox(width: 10),
                              Container(
                                height: 30,
                                width: 75,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    clearTextInput();
                                  },
                                  color: bluecancel,
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontFamily: 'IBMPlexSans',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          });
        });
  }

  _result(Map<String, dynamic> results) {
    Commons.showToast(
        context: context, message: results["message"], duration: 3);

    clearTextInput();
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget _buildListAcademic(_semesterList) {
    return _semesterList.length > 0
        ? _searchResult.length != 0 || _searchController.text.isNotEmpty
            ? _searchResult.length == 0
                ? CustomText(
                    text: "  No records found",
                    color: mainAppColor,
                  )
                : ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SemeterItem(
                        Index: index,
                        semester: _searchResult[index],
                      );
                    })
            : ListView.builder(
                itemCount: _semesterList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SemeterItem(
                    Index: index,
                    semester: _semesterList[index],
                  );
                })
        : NoData(message: 'No Semetster');
  }
}
