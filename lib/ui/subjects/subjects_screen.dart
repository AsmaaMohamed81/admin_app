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
  double _width = 0.0;
  bool _initialRun = true;
  AuthProvider _authProvider;
  String _materialName, _abberviation = '';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final nameHolder = TextEditingController();
  final nameHolder2 = TextEditingController();

  List<Subjects> _searchResult = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Subjects> _subjectsList = [];
  clearTextInput() {
    nameHolder.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBodyItem() {
    return RefreshIndicator(
        onRefresh: () async {},
        child: BlocListener<SubjectsBloc, SubjectsState>(
          listener: (context, state) {
            if (state is SubjectsAddOrEdite) {
              if (state.results['status'] == "Success") {
                _result(state.results);
              } else {
                Commons.showError(context, state.results["message"]);
              }
            } else if (state is SubjectsDeleted) {
              if (state.message['status'] == "Success") {
                _result(state.message);
              } else {
                Commons.showError(context, state.message["message"]);
              }
            }
          },
          child: Stack(
            children: [
              // Container(
              //   height: 80,
              //   decoration: BoxDecoration(
              //     color: mainAppColor,
              //     borderRadius: BorderRadius.only(
              //         topLeft: Radius.zero,
              //         topRight: Radius.zero,
              //         bottomLeft: Radius.circular(20.0),
              //         bottomRight: Radius.circular(20.0)),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.03),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: searchcolor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextField(
                        controller: _searchController,
                        cursorColor: mainAppColor,
                        onChanged: (text) {
                          _searchResult.clear();

                          if (text.isEmpty) {
                            setState(() {});
                            print("empty");
                            return;
                          } else {
                            setState(() {});

                            _subjectsList.forEach((userDetail) {
                              if (userDetail.name
                                  .toLowerCase()
                                  .contains(text.toLowerCase())) {
                                _searchResult.add(userDetail);
                              }
                            });
                          }
                        },
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: mainAppColor),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12.0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: black,
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
                        } else if (state is DeletSubjects) {
                        } else if (state is SubjectsLoaded) {
                          _subjectsList = state.subjects;
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
            ],
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
                      );
                    })
            : ListView.builder(
                itemCount: _subjectsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubjectsItem(
                    subjects: _subjectsList[index],
                  );
                })
        : NoData(message: 'No Subject');
  }

  _result(Map<String, dynamic> results) {
    Commons.showToast(
      context: context,
      message: results["message"],
    );

    clearTextInput();
    FocusScopeNode currentFocus = FocusScope.of(context);
    sleep1();

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    _initialRun = true;
  }

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 10), () => "1");
  }

  Widget _buildSaveBtn(context) {
    return BlocBuilder<SubjectsBloc, SubjectsState>(
      builder: (context, state) {
        SubjectsBloc bloc = BlocProvider.of<SubjectsBloc>(context);

        return Container(
          height: 30,
          width: 75,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () async {
              print("in");

              if (_formKey.currentState.validate()) {
                print("injjjjjjjjjj");

                bloc.add(AddOrEditSubjects(
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
      },
    );
  }

  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return new Container(
              margin: EdgeInsets.only(bottom: 50),
              padding: EdgeInsets.all(50),
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
                          hintText: "Subject Name",
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                      TextFormField(
                        controller: nameHolder2,
                        onChanged: (value) {
                          _abberviation = value;
                        },
                        validator: validateSubjects,
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          hintText: "Abberviation",
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
                              onPressed: () => Navigator.of(context).pop(),
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
                          SizedBox(width: 7),
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

    final appBar = AppBar(
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
      title: Center(
          child:
              Text("Subjects", style: Theme.of(context).textTheme.headline1)),
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
            child: BlocProvider(
                create: (context) => SubjectsBloc(SubjectsRepositoryImp())
                  ..add(FetchSubjects(_authProvider.ownSchool.id)),
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
                    child: FloatingActionButton(
                      backgroundColor: floatbottom,
                      onPressed: () => _settingModalBottomSheet(context),
                      tooltip: 'Increment Counter',
                      child: const Icon(Icons.add),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endDocked,
                  body: _buildBodyItem(),
                  resizeToAvoidBottomInset: false,
                ))));
  }
}