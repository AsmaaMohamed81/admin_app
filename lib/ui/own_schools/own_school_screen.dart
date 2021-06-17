import 'package:admin_app/bloc/own_school_bloc/own_school_bloc.dart';
import 'package:admin_app/custom_widget/dialogs/connectivity/network_indicator.dart';
import 'package:admin_app/custom_widget/safe_area/page_container.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/repository/own_schools_repository.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'own_school.item.dart';

class OwnSchoolsScreen extends StatefulWidget {
  @override
  _OwnSchoolsScreenState createState() => _OwnSchoolsScreenState();
}

class _OwnSchoolsScreenState extends State<OwnSchoolsScreen>
    with ValidationMixin {
  TextEditingController _searchController = TextEditingController();
  double _width = 0.0;
  bool _initialRun = true;
  AuthProvider _authProvider;

  String _materialName = '';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final nameHolder = TextEditingController();

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
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.03),
          child: BlocBuilder<OwnSchoolBloc, OwnSchoolState>(
              builder: (context, state) {
            if (state is OwnSchoolLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OwnSchoolLoaded) {
              if (state.ownSchool.length > 0) {
                return ListView.builder(
                    itemCount: state.ownSchool.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OwnSchoolsItem(
                        ownSchool: state.ownSchool[index],
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    "You Should Be Admin First",
                    style: TextStyle(color: mainAppColor),
                  ),
                );
              }
            } else if (state is OwnSchoolError) {
              return Text(
                state.message,
                style: TextStyle(color: mainAppColor),
              );
            }
            return Center(
              child: Text(
                "NO School For Admin",
                style: TextStyle(color: mainAppColor),
              ),
            );
          }),
        ));
  }

  _result(Map<String, dynamic> results) {
    Commons.showToast(
      context: context,
      message: results["message"],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("jjkjjkjkhkll");

    _authProvider = Provider.of<AuthProvider>(context);
    return NetworkIndicator(
        child: PageContainer(
            child: BlocProvider(
      create: (context) => OwnSchoolBloc(schoolsRepositoryImp())
        ..add(FetchOwnSchools(_authProvider.currentUser.accessToken)),
      child: Scaffold(
          appBar: AppBar(
            title: Text("OwnSchools"),
          ),
          body: _buildBodyItem()),
    )));
  }
}
