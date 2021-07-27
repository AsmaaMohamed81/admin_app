import 'package:admin_app/bloc/classes_bloc/classes_bloc.dart';
import 'package:admin_app/custom_widget/app_drawer/app_drawer.dart';
import 'package:admin_app/custom_widget/appbar/appbar.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/dialogs/connectivity/network_indicator.dart';
import 'package:admin_app/custom_widget/no_data/no_data.dart';
import 'package:admin_app/custom_widget/safe_area/page_container.dart';
import 'package:admin_app/data/model/classes.dart';
import 'package:admin_app/data/repository/classes.repository.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/ui/education_classes/arguments.dart';
import 'package:admin_app/ui/education_classes/widgets/class_item.dart';
import 'package:admin_app/ui/education_classes/widgets/new_class.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'widgets/adding_new_class_dialog.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  AppBarCustom _appBarCustom;
  double _width = 0.0;
  AuthProvider _authProvider;
  TextEditingController _searchController = TextEditingController();
  List<Classes> _searchResult = [];
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Classes> _classesList = [];
  @override
  void initState() {
    super.initState();
  }

  bool istext = false;
  clearTextInput() {
    _searchController.clear();
  }

  // void _filterList(value) {
  //   setState(() {
  //     _searchResult = _classesList
  //         .where((text) =>
  //             text.name.toLowerCase().contains(value.toLowerCase()) ||
  //             text.levelName.toLowerCase().contains(value.toLowerCase()) ||
  //             text.academicYearName.toLowerCase().contains(value.toLowerCase()))
  //         .toList(); // I don't understand your Word list.
  //   });
  // }

  Widget _buildEducationClasses() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Education Classes",
            style: TextStyle(
                color: mainAppColor, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: mainAppColor,
              size: 24,
            ),
            onPressed: () {
              // showDialog(
              //     barrierDismissible: true,
              //     context: context,
              //     builder: (_) {
              //       return AddingNewClassDialog(
              //         value: 0,
              //       );
              //     });

              Navigator.pushNamed(
                context,
                '/new_class',
                arguments: Arguments(null, 0),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildBodyItem() {
    return RefreshIndicator(
        onRefresh: () async {
          return await setState(() {});
        },
        child: BlocListener<ClassesBloc, ClassesState>(
            listener: (context, state) {
              if (state is ClassesAddOrEdite) {
                if (state.results['status'] == "Success") {
                  _result(state.results);
                } else {
                  Commons.showError(context, state.results["message"], null);
                }
              } else if (state is ClassesDeleted) {
                if (state.message['status'] == "Success") {
                  _result(state.message);
                } else {
                  Commons.showError(context, state.message["message"], null);
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
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                _searchResult.clear();

                                if (value.isEmpty) {
                                  setState(() {});
                                  print("empty");
                                  return;
                                } else {
                                  istext = true;
                                  _classesList.forEach((text) {
                                    if (text.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        text.levelName
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        text.academicYearName
                                            .toLowerCase()
                                            .contains(value.toLowerCase())) {
                                      _searchResult.add(text);
                                    }
                                  });
                                  setState(() {});
                                }
                              },
                              controller: _searchController,
                              cursorColor: mainAppColor,
                              onFieldSubmitted: (value) {
                                _searchResult.clear();

                                if (value.isEmpty) {
                                  setState(() {});
                                  print("empty");
                                  return;
                                } else {
                                  istext = true;
                                  _classesList.forEach((text) {
                                    if (text.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        text.levelName
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        text.academicYearName
                                            .toLowerCase()
                                            .contains(value.toLowerCase())) {
                                      _searchResult.add(text);
                                    }
                                  });
                                  setState(() {});
                                }
                              },
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                suffixIcon: istext
                                    ? IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          clearTextInput();
                                          _searchResult.clear();

                                          setState(() {
                                            istext = false;
                                          });
                                        })
                                    : null,
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
                                hintText: "Search Classes",
                              ),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        _buildEducationClasses(),
                        Expanded(
                          child: BlocBuilder<ClassesBloc, ClassesState>(
                              builder: (context, state) {
                            if (state is ClassesLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is ClassesLoaded) {
                              _classesList = state.classes;

                              // if (!doItJustOnce) {
                              //   //You should define a bool like (bool doItJustOnce = false;) on your state.
                              //   _classesList = state.classes;
                              //   _searchResult = _classesList;
                              //   doItJustOnce =
                              //       !doItJustOnce; //this line helps to do just once.
                              // }
                              // _searchResult = _classesList;

                              return _buildListLevels(_classesList);
                            } else if (state is ClassesError) {
                              return Text(state.message.toString());
                            }
                            return Container();
                          }),
                        ),
                      ],
                    )),
              ],
            )));
  }

  Widget _buildListLevels(_classesList) {
    return _classesList.length > 0
        ? _searchResult.length != 0 || _searchController.text.isNotEmpty
            ? _searchResult.length == 0
                ? CustomText(
                    text: "  No records found",
                    color: mainAppColor,
                  )
                : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: _searchResult.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          MediaQuery.of(context).size.height * .0020,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: ClassItem(
                          classes: _searchResult[index],
                          index: index,
                        ),
                      );
                    })
            : GridView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: _classesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.height * .0020,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: ClassItem(
                      classes: _classesList[index],
                      index: index,
                    ),
                  );
                })
        : NoData(message: 'No Subject');
  }

  _result(Map<String, dynamic> results) {
    Commons.showToast(
      context: context,
      message: results["message"],
    );
  }

  @override
  Widget build(BuildContext context) {
    _appBarCustom = AppBarCustom(title: "Classes", keyScafold: _scaffoldKey);
    _authProvider = Provider.of<AuthProvider>(context);

    _width = MediaQuery.of(context).size.width;
    context.read<ClassesBloc>()..add(FetchClasses(_authProvider.ownSchool.id));

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
                appBar: _appBarCustom.appBarCustom(),
                body: _buildBodyItem())));
  }
}
