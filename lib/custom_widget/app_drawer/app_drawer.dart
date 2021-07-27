import 'package:admin_app/custom_widget/dialogs/log_out_dialog.dart';
import 'package:admin_app/locale/app_localizations.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/shared_preferences/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  AuthProvider _authProvider;
  bool log = false;

  Widget _buildDrawerItem(String itemName, Widget icon) {
    return Container(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            icon,
            SizedBox(
              width: 20,
            ),
            Text(
              itemName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 14,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ));
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  child: Center(
                      child: Text(
                'Talent Notation',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home_screen');
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
                leading: Icon(
                  FontAwesomeIcons.home,
                  color: Colors.white,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                onTap: () {
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, '/home_feeds_screen');
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
                leading: Icon(
                  FontAwesomeIcons.language,
                  color: Colors.white,
                ),
                title: Text(
                  'language',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/level_screen');
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
                leading: Icon(
                  FontAwesomeIcons.pooStorm,
                  color: Colors.white,
                ),
                title: Text(
                  'Levels',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/subjects_screen');
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
                leading: Icon(
                  FontAwesomeIcons.addressBook,
                  color: Colors.white,
                ),
                title: Text(
                  'Subjects',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/classes_screen');
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
                leading: Icon(
                  FontAwesomeIcons.addressBook,
                  color: Colors.white,
                ),
                title: Text(
                  'Classes',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/academic_years_screen');
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
                leading: Icon(
                  FontAwesomeIcons.addressBook,
                  color: Colors.white,
                ),
                title: Text(
                  'Academic Years',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              _checkLog(context),
              Divider(
                color: Colors.white,
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    if (_authProvider.currentUser != null) {
      print("dfdfdfdfdddddddsffffsd");
      setState(() {
        log = true;
      });
    } else {
      setState(() {
        log = false;
      });
    }

    return _buildNavigationDrawer(context);
  }

  Widget _checkLog(BuildContext context) {
    if (log == false) {
      return ListTile(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/login_screen');
        },
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 14,
        ),
        leading: Icon(
          FontAwesomeIcons.signInAlt,
          color: Colors.white,
        ),
        title: Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      );
    } else {
      return ListTile(
        onTap: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) {
                return LogoutDialog(
                  button1: AppLocalizations.of(context).translate('ok'),
                  button2: AppLocalizations.of(context).translate('cancel'),
                  alertMessage:
                      AppLocalizations.of(context).translate('want_to_logout'),
                  onPressedConfirm: () {
                    Navigator.pop(context);
                    SharedPreferencesHelper.remove("user");

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login_screen', (Route<dynamic> route) => false);
                  },
                );
              });
        },
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 14,
        ),
        leading: Icon(
          FontAwesomeIcons.signInAlt,
          color: Colors.white,
        ),
        title: Text(
          'Logout',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      );
    }
  }
}
