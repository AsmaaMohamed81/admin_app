import 'package:admin_app/custom_widget/buttons/custom_button.dart';
import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/custom_widget/custom_text_form/custom_text_form_field_auth.dart';
import 'package:admin_app/custom_widget/safe_area/page_container.dart';
import 'package:admin_app/custom_widget/validation_mixin.dart';
import 'package:admin_app/data/model/user.dart';
import 'package:admin_app/locale/app_localizations.dart';
import 'package:admin_app/networking/api_provider.dart';
import 'package:admin_app/provider/auth_provider.dart';
import 'package:admin_app/shared_preferences/shared_preferences_helper.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:admin_app/utils/commons.dart';
import 'package:admin_app/utils/hex_color.dart';
import 'package:admin_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  double _width = 0;
  String _userEmail = '', _userPassword = '';
  final _formKey = GlobalKey<FormState>();
  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider;
  bool _isLoading = false;

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/logobig.png',
                height: 180,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomText(
                color: mainAppColor,
                text: AppLocalizations.of(context).translate("signin"),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: MediaQuery.of(context).size.width * .85,
              color: mainAppColor,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormFieldAuth(
              text: 'emailorusername',
              hintText: 'Enter your email or user name',
              onChange: (text) {
                _userEmail = text;
              },
              validator: validateemailsignin,
            ),
            SizedBox(
              height: 5,
            ),
            CustomTextFormFieldAuth(
              text: 'password',
              hintText: 'Enter your password',
              onChange: (text) {
                _userPassword = text;
              },
              validator: validatePasswordsignin,
              obsecureText: true,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                AppLocalizations.of(context).translate('forget_password'),
                style: TextStyle(
                    decoration: TextDecoration.underline, color: mainAppColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              margin: EdgeInsets.only(
                left: _width * 0.05,
                right: _width * 0.05,
                top: 5,
              ),
              child:
                  Align(alignment: Alignment.center, child: _buildLoginBtn()),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                color: mainAppColor,
                text: AppLocalizations.of(context).translate("orsignin"),
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: _width * 0.25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 47,
                    width: _width * 0.12,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff70707033)),
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Image.asset(
                      'assets/images/googlecolors.png',
                      scale: 1.5,
                    ),
                  ),
                  Container(
                    height: 47,
                    width: _width * 0.12,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff70707033)),
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.blue.shade800,
                      size: 20,
                    ),
                  ),
                  Container(
                    height: 47,
                    width: _width * 0.12,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff70707033)),
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Icon(
                      FontAwesomeIcons.microsoft,
                      color: Colors.lightBlue,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/sign_up_screen'),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'IBMPlexSans',
                        color: HexColor('95A7B5')),
                    children: <TextSpan>[
                      new TextSpan(
                          text: AppLocalizations.of(context)
                              .translate("donot_have_an_account")),
                      TextSpan(text: (' ')),
                      new TextSpan(
                          text: AppLocalizations.of(context)
                              .translate("register"),
                          style: new TextStyle(
                              fontSize: 15,
                              fontFamily: 'NeoSans',
                              color: mainAppColor)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      width: _width * 0.42,
      child: CustomButton(
        borderColor: mainAppColor,
        btnColor: mainAppColor,
        btnLbl: AppLocalizations.of(context).translate('signin'),
        btnStyle: TextStyle(color: Colors.white, fontSize: 16),
        onPressedFunction: () async {
          print(_userEmail);
          print(_userPassword);
          if (_formKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });
            Map<String, dynamic> results = await _apiProvider.post(
                Urls.LOGIN_URL,
                body: {"email": _userEmail, "password": _userPassword});
            setState(() => _isLoading = false);
            if (results['status'] == "Success") {
              _login(results);
            } else {
              Commons.showError(context, results["message"]);
            }
          }
        },
      ),
    );
  }

  _login(Map<String, dynamic> results) {
    _authProvider.setCurrentUser(User.fromJson(results["data"]));
    print(_authProvider.currentUser.email);
    SharedPreferencesHelper.save("user", _authProvider.currentUser);

    Navigator.pushReplacementNamed(context, '/own_schools_screen');
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    return PageContainer(
      child: Scaffold(
        body: Stack(
          children: [
            _buildBodyItem(),
            _isLoading
                ? Center(
                    child: SpinKitFadingCircle(color: mainAppColor),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
