import 'package:admin_app/custom_widget/app_drawer/app_drawer.dart';
import 'package:admin_app/custom_widget/dialogs/connectivity/network_indicator.dart';
import 'package:admin_app/custom_widget/safe_area/page_container.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthProvider _authProvider;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      title: Text("Home", style: Theme.of(context).textTheme.headline1),
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
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: mainAppColor,
          ),
          child: AppDrawer(),
        ),
        key: _scaffoldKey,
        appBar: appBar,
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text("WELCOM IN",
                    style: TextStyle(color: mainAppColor, fontSize: 25)),
              ),
              Container(
                height: 200,
                width: 200,
                child: FadeInImage(
                  image: NetworkImage('${_authProvider.ownSchool.photopath}'),
                  placeholder: AssetImage("assets/images/logo.png"),
                ),
              ),
              Text(
                _authProvider.ownSchool.name,
                style: TextStyle(color: mainAppColor, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
