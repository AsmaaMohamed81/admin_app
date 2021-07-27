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

class AcademicYears extends StatefulWidget {
  @override
  _AcademicYearsState createState() => _AcademicYearsState();
}

class _AcademicYearsState extends State<AcademicYears> with ValidationMixin {
  AppBarCustom _appBarCustom;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Academic> _searchResult = [];
  List<Academic> _academicList = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AcademicBloc>()
      ..add(FetchAcademic(
          Provider.of<AuthProvider>(context, listen: false).ownSchool.id));
  }

  @override
  Widget build(BuildContext context) {
    _appBarCustom =
        AppBarCustom(title: "Academic Years", keyScafold: _scaffoldKey);

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
          appBar: _appBarCustom.appBarCustom(),
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
    return BlocConsumer<AcademicBloc, AcademicState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is AcademicLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AcademicLoaded) {
          _academicList = state.academic;

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

          return _buildListAcademic(_academicList);
        } else if (state is AcademicError) {
          return Text(state.message.toString());
        }
        return Container();
      },
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
            print("injjjjjjjjjj");
            // valueu = 0;

            // context.read<SubjectsBloc>().add(AddOrEditSubjects(
            //     _authProvider.currentUser.accessToken,
            //     0,
            //     _authProvider.ownSchool.id,
            //     _materialName,
            //     _abberviation, []));

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
                        // controller: nameHolder,
                        // onChanged: (value) {
                        //   _materialName = value;
                        // },
                        validator: validateSubjects,
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          errorStyle: TextStyle(fontSize: 9),
                          hintText: "Subject Name",
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                      TextFormField(
                        // controller: nameHolder2,
                        // onChanged: (value) {
                        //   _abberviation = value;
                        // },
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
                                // clearTextInput();
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

  Widget _buildListAcademic(_academicList) {
    return _academicList.length > 0
        ? _searchResult.length != 0 || _searchController.text.isNotEmpty
            ? _searchResult.length == 0
                ? CustomText(
                    text: "  No records found",
                    color: mainAppColor,
                  )
                : ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AcademicItem(
                        academic: _academicList[index],
                        listAcademic: _academicList,
                      );
                    })
            : ListView.builder(
                itemCount: _academicList.length,
                itemBuilder: (BuildContext context, int index) {
                  return AcademicItem(
                    academic: _academicList[index],
                    listAcademic: _academicList,
                  );
                })
        : NoData(message: 'No Subject');
  }
}
