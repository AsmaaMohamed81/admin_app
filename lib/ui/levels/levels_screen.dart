import 'package:admin_app/bloc/levels_bloc/levels_bloc.dart';
import 'package:admin_app/custom_widget/app_drawer/app_drawer.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/dialogs/connectivity/network_indicator.dart';
import 'package:admin_app/custom_widget/no_data/no_data.dart';
import 'package:admin_app/custom_widget/safe_area/page_container.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/level.dart';
import 'package:admin_app/data/repository/level.repository.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'levels.item.dart';

class LevelsScreen extends StatefulWidget {
  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> with ValidationMixin {
  TextEditingController _searchController = TextEditingController();

  AuthProvider _authProvider;
  String _materialName = '';
  final _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

  final nameHolder = TextEditingController();
  List<Levels> _searchResult = [];

  List<Levels> _levelList = [];
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
        child: BlocListener<LevelsBloc, LevelsState>(
          listener: (context, state) {
            if (state is LevelsAddOrEdite) {
              if (state.results['status'] == "Success") {
                _result(state.results);
              } else {
                Commons.showError(context, state.results["message"]);
              }
            } else if (state is LevelsDeleted) {
              if (state.message['status'] == "Success") {
                _result(state.message);
              } else {
                Commons.showError(context, state.message["message"]);
              }
            }
          },
          child: Stack(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: mainAppColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.03),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextFormField(
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

                            _levelList.forEach((userDetail) {
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
                            color: mainAppColor,
                          ),
                          hintText: "Search levels",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildAddLevels(),
                    Expanded(
                      child: BlocBuilder<LevelsBloc, LevelsState>(
                          builder: (context, state) {
                        if (state is LevelLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is DeletLevels) {
                        } else if (state is LevelLoaded) {
                          _levelList = state.levels;
                          return _buildListLevels(_levelList);
                        } else if (state is LevelError) {
                          return Text("sorry");
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

  Widget _buildListLevels(_levelList) {
    return _levelList.length > 0
        ? _searchResult.length != 0 || _searchController.text.isNotEmpty
            ? _searchResult.length == 0
                ? CustomText(
                    text: "  No records found",
                    color: mainAppColor,
                  )
                : ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LevelsItem(
                        levels: _searchResult[index],
                      );
                    })
            : ListView.builder(
                itemCount: _levelList.length,
                itemBuilder: (BuildContext context, int index) {
                  return LevelsItem(
                    levels: _levelList[index],
                  );
                })
        : NoData(message: 'No Levels');
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
  }

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 10), () => "1");
  }

  Widget _buildAddLevels() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: nameHolder,
          onChanged: (value) {
            _materialName = value;
          },
          validator: validatelevel,
          decoration: InputDecoration(
            errorMaxLines: 2,
            hintText: "Add New Level",
            hintStyle: TextStyle(fontSize: 12),
            suffixIcon: Padding(
                padding: EdgeInsets.only(top: 5), child: _buildSaveBtn()),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveBtn() {
    return BlocBuilder<LevelsBloc, LevelsState>(
      builder: (context, state) {
        LevelsBloc bloc = BlocProvider.of<LevelsBloc>(context);

        return Container(
            child: GestureDetector(
          child: Icon(
            Icons.add,
            color: mainAppColor,
          ),
          onTap: () async {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            if (_formKey.currentState.validate()) {
              bloc.add(AddOrEditLevels(_authProvider.currentUser.accessToken, 0,
                  _authProvider.ownSchool.id, _materialName));
            }
          },
        ));
      },
    );
  }

  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      title: Text("Levels", style: Theme.of(context).textTheme.headline1),
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
                create: (context) => LevelsBloc(LevelsRepositoryImp())
                  ..add(FetchLevels(_authProvider.ownSchool.id)),
                child: Scaffold(
                  drawer: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: mainAppColor,
                    ),
                    child: AppDrawer(),
                  ),
                  key: _scaffoldKey,
                  appBar: appBar,
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex:
                        2, // this will be set when a new tab is tapped

                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person_outline_outlined,
                        ),
                        label: " ",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.notifications,
                        ),
                        label: " ",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.shopping_cart,
                        ),
                        label: " ",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.more_horiz,
                        ),
                        label: " ",
                      ),
                    ],
                    selectedItemColor: mainAppColor,
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.grey,
                    iconSize: 30,

                    elevation: 5,
                    onTap: _onItemTap,
                  ),
                  body: _buildBodyItem(),
                  resizeToAvoidBottomInset: false,
                ))));
  }
}
