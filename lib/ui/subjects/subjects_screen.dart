import 'package:admin_app/bloc/subjects_bloc/subjects_bloc.dart';
import 'package:admin_app/custom_widget/app_drawer/app_drawer.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/demobottomappbar.dart';
import 'package:admin_app/custom_widget/dialogs/connectivity/network_indicator.dart';
import 'package:admin_app/custom_widget/no_data/no_data.dart';
import 'package:admin_app/custom_widget/safe_area/page_container.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/subjects.dart';
import 'package:admin_app/data/repository/subjects.repository.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'widget/subjects.item.dart';

class SubjectsScreen extends StatefulWidget {
  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> with ValidationMixin {
  TextEditingController _searchController = TextEditingController();

  AuthProvider _authProvider;
  String _materialName, _abberviation = '';
  final _formKey = GlobalKey<FormState>();

  int valueu;

  final nameHolder = TextEditingController();
  final nameHolder2 = TextEditingController();

  List<Subjects> _searchResult = [];
  List<Subjects> _subjectsList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String textSearch;
  clearTextInput() {
    nameHolder.clear();
    nameHolder2.clear();
  }

  @override
  void initState() {
    super.initState();
    context.read<SubjectsBloc>()
      ..add(FetchSubjects(
          Provider.of<AuthProvider>(context, listen: false).ownSchool.id));
  }

  Widget _buildBodyItem() {
    var d = context.read<SubjectsBloc>().state;
    print("stattedsjdjsdhjhghjghje====${d}");
    return RefreshIndicator(
        onRefresh: () async {
          // return await setState(() {});
        },
        child: BlocListener<SubjectsBloc, SubjectsState>(
          listener: (context, state) {
            print("sttae==== ${state}");

            if (state is SubjectsAddOrEdite) {
              if (state.results['status'] == "Success") {
                _result(state.results);
              } else {
                print("bootom sheet re open");

                print("nonoononononon");
                Commons.showError(context, state.results["message"], () {
                  if (valueu == 0) {
                    _settingModalBottomSheet(context);
                    valueu = null;
                  }
                });
              }
            } else if (state is SubjectsAddOrEditeEdite) {
              if (state.results['status'] == "Success") {
                Navigator.of(context).pop();
              } else {
                Commons.showError(context, state.results["message"], () {});
              }
            } else if (state is SubjectsAddOrEditeSelecte) {
              if (state.results['status'] == "Success") {
                Commons.showToast(
                    context: context,
                    message: "The teacher has been saved successfully",
                    duration: 3);
              }
            } else if (state is SubjectsDeleted) {
              if (state.message['status'] == "Success") {
                _result(state.message);
              } else {
                Commons.showError(context, state.message["message"], () {});
              }
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.03),
            child: Column(
              children: <Widget>[
                Container(
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
                      textSearch = text;
                      _searchResult.clear();

                      if (text.isEmpty) {
                        setState(() {});
                        print("empty");
                        return;
                      } else {
                        setState(() {
                          _subjectsList.forEach((userDetail) {
                            if (userDetail.name
                                    .toLowerCase()
                                    .contains(text.toLowerCase()) ||
                                userDetail.abbreviation
                                    .toLowerCase()
                                    .contains(text.toLowerCase())) {
                              _searchResult.add(userDetail);
                            }
                          });
                        });
                      }
                    },
                    onChanged: (text) {
                      textSearch = text;

                      _searchResult.clear();

                      if (text.isEmpty) {
                        setState(() {});
                        print("empty");
                        return;
                      } else {
                        setState(() {
                          _subjectsList.forEach((userDetail) {
                            if (userDetail.name
                                    .toLowerCase()
                                    .contains(text.toLowerCase()) ||
                                userDetail.abbreviation
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
                      hintText: "Search Subjects",
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // _buildAddSubjects(),
                Expanded(
                  child: BlocBuilder<SubjectsBloc, SubjectsState>(
                      builder: (context, state) {
                    if (state is SubjectsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SubjectsLoaded) {
                      _subjectsList = state.subjects;

                      print(
                          "_subjectsList[0].abbreviation == ${_subjectsList[0].abbreviation}");
                      if (_searchResult.length > 0) {
                        _searchResult.clear();
                        _subjectsList.forEach((userDetail) {
                          if (userDetail.name
                                  .toLowerCase()
                                  .contains(textSearch.toLowerCase()) ||
                              userDetail.abbreviation
                                  .toLowerCase()
                                  .contains(textSearch.toLowerCase())) {
                            _searchResult.add(userDetail);
                          }
                        });
                      }

                      return _buildListSubjects(_subjectsList);
                    } else if (state is SubjectsError) {
                      return Text(state.message.toString());
                    }
                    return Container();
                  }),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildListSubjects(_subjectsList) {
    return _subjectsList.length > 0
        ? _searchResult.length != 0 || _searchController.text.isNotEmpty
            ? _searchResult.length == 0
                ? CustomText(
                    text: "  No records found",
                    color: mainAppColor,
                  )
                : ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SubjectsItem(
                        subjects: _searchResult[index],
                        listobject: _subjectsList,
                      );
                    })
            : ListView.builder(
                itemCount: _subjectsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubjectsItem(
                    subjects: _subjectsList[index],
                    listobject: _subjectsList,
                  );
                })
        : NoData(message: 'No Subject');
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

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 10), () => "1");
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
            print("injjjjjjjjjj");
            valueu = 0;

            context.read<SubjectsBloc>().add(AddOrEditSubjects(
                _authProvider.currentUser.accessToken,
                0,
                _authProvider.ownSchool.id,
                _materialName,
                _abberviation, []));

            Navigator.of(context).pop();
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
        builder: (builder) {
          return new Container(
              padding: EdgeInsets.fromLTRB(50, 50, 50, 10),
              height: 250.0,
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
                        controller: nameHolder,
                        onChanged: (value) {
                          _materialName = value;
                        },
                        validator: validateSubjects,
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          errorStyle: TextStyle(fontSize: 9),
                          hintText: "Subject Name",
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                      TextFormField(
                        controller: nameHolder2,
                        onChanged: (value) {
                          _abberviation = value;
                        },
                        validator: validateAbberviation,
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          errorStyle: TextStyle(fontSize: 9),
                          hintText: "Abbreviation",
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    print("textSearch= ${textSearch}");
    print("${_searchResult.length}");

    print("vlaue first $valueu");

    var d = context.read<SubjectsBloc>().state;
    print("stattedsjdjsdhjhghjghje====${d}");
    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: mainAppColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      )),
      leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Image.asset(
            'assets/images/menu.png',
            color: Colors.white,
          )),
      title: Text("Subjects", style: Theme.of(context).textTheme.headline1),
    );

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
      appBar: appBar,
      bottomNavigationBar: DemoBottomAppBar(),
      floatingActionButton: Container(
        height: 60.0,
        width: 60.0,
        padding: EdgeInsets.all(5),
        child: Commons.isKeyboardHidden(context)
            ? FloatingActionButton(
                backgroundColor: floatbottom,
                onPressed: () {
                  print("vlaue open bottom $valueu");

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
    )));
  }
}
