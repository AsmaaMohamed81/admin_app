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

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ValidationMixin {
  double _height = 0;
  double _width = 0;
  String _userEmail = '',
      _userPassword = '',
      _userName = '',
      _confirmPassword = '',
      _firstName = '',
      _lastName = '',
      _phone = '';
  final _formKey = GlobalKey<FormState>();
  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider;
  bool _isLoading = false;

  Map userProfile;

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
                height: 70,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                color: mainAppColor,
                text: AppLocalizations.of(context).translate("register"),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 300,
              color: mainAppColor,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormFieldAuth(
                    text: 'first_name',
                    hintText: 'Enter your first name',
                    onChange: (text) {
                      _firstName = text;
                    },
                    validator: validateFirstName,
                  ),
                ),
                Expanded(
                  child: CustomTextFormFieldAuth(
                    text: 'last_name',
                    hintText: 'Enter your last name',
                    onChange: (text) {
                      _lastName = text;
                    },
                    validator: validatelastName,
                  ),
                ),
              ],
            ),
            CustomTextFormFieldAuth(
              text: 'user_name',
              hintText: 'Enter your user name',
              onChange: (text) {
                _userName = text;
              },
              validator: validateUserName,
            ),
            CustomTextFormFieldAuth(
              text: 'email',
              hintText: 'Enter your email',
              onChange: (text) {
                _userEmail = text;
              },
              validator: validateUserEmail,
            ),
            CustomTextFormFieldAuth(
              text: 'phone_no',
              hintText: 'Enter your phone number',
              onChange: (text) {
                _phone = text;
              },
            ),
            CustomTextFormFieldAuth(
              text: 'password',
              hintText: 'Enter your password',
              onChange: (text) {
                _userPassword = text;
              },
              validator: validatePasswordsignup,
              obsecureText: true,
            ),
            CustomTextFormFieldAuth(
              text: 'confirm_password',
              hintText: 'Enter your password again',
              onChange: (text) {
                _confirmPassword = text;
              },
              validator: validateConfirmPassword,
              obsecureText: true,
            ),
            Container(
              height: _height * 0.08,
              margin: EdgeInsets.only(
                left: _width * 0.05,
                right: _width * 0.05,
                top: _height * 0.01,
              ),
              child:
                  Align(alignment: Alignment.center, child: _buildSignUpBtn()),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                color: mainAppColor,
                text: AppLocalizations.of(context).translate("orsignup"),
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: 10,
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login_screen'),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'IBMPlexSans',
                        color: HexColor('95A7B5')),
                    children: <TextSpan>[
                      new TextSpan(
                          text: AppLocalizations.of(context)
                              .translate("do_you_have_an_account")),
                      new TextSpan(text: ' '),
                      new TextSpan(
                          text:
                              AppLocalizations.of(context).translate("signin"),
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

  Widget _buildSignUpBtn() {
    return Container(
      height: _height * 0.06,
      width: _width * 0.42,
      child: CustomButton(
        borderColor: mainAppColor,
        btnColor: mainAppColor,
        btnLbl: AppLocalizations.of(context).translate("register"),
        btnStyle: TextStyle(color: Colors.white, fontSize: 16),
        onPressedFunction: () async {
          if (_formKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });
            Map<String, dynamic> results =
                await _apiProvider.post(Urls.REGISTER_URL, body: {
              "userName": _userName,
              "email": _userEmail,
              "password": _userPassword,
              "confirmPassword": _confirmPassword,
              "phone": _phone,
              "firstName": _firstName,
              "lastName": _lastName,
              "zoomUserId": " "
            });
            setState(() => _isLoading = false);
            if (results['status'] == "Success") {
              _register(results);
            } else {
              Commons.showError(context, results["message"],null);
            }
          }
        },
      ),
    );
  }

  _register(Map<String, dynamic> results) {
    _authProvider.setCurrentUser(User.fromJson(results["data"]));
    SharedPreferencesHelper.save("user", _authProvider.currentUser);

    Navigator.pushReplacementNamed(context, '/own_schools_screen');
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    return PageContainer(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
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
