import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';

import 'app_colors.dart';

class Commons {
  // static const baseURL = "https://api.chucknorris.io/";
  // static const tileBackgroundColor = const Color(0xFFF1F1F1);
  // static const chuckyJokeBackgroundColor = const Color(0xFFF1F1F1);
  // static const chuckyJokeWaveBackgroundColor = const Color(0xFFA8184B);
  // static const gradientBackgroundColorEnd = const Color(0xFF601A36);
  // static const gradientBackgroundColorWhite = const Color(0xFFFFFFFF);
  // static const mainAppFontColor = const Color(0xFF4D0F29);
  // static const appBarBackGroundColor = const Color(0xFF4D0F28);
  // static const categoriesBackGroundColor = const Color(0xFFA8184B);
  // static const hintColor = const Color(0xFF4D0F29);
  // static const mainAppColor = const Color(0xFF4D0F29);
  // static const gradientBackgroundColorStart = const Color(0xFF4D0F29);
  // static const popupItemBackColor = const Color(0xFFDADADB);

  static Widget chuckyLoader() {
    return Center(child: SpinKitFoldingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Color(0xFFFFFFFF) : Color(0xFF311433),
          ),
        );
      },
    ));
  }

  static void showError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                message,
                style: TextStyle(fontSize: 13),
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  static Widget chuckyLoading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10), child: Text(message)),
        chuckyLoader(),
      ],
    );
  }

  // static Future logout(BuildContext context) async {
  //   final storage = new FlutterSecureStorage();
  //   await storage.deleteAll();

  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => LoginScreen()));
  // }

// handleUnauthenticated(BuildContext context) {
//   showDialog(
//       barrierDismissible: false, // user must tap button!
//       context: context,
//       builder: (_) {
//         return ResponseAlertDialog(
//           alertTitle: 'عفواً',
//           alertMessage: 'يرجي تسجيل الدخول مجدداً',
//           alertBtn: 'موافق',
//           onPressedAlertBtn: () {
//             Navigator.pop(context);
//             SharedPreferencesHelper.remove("user");
//             Navigator.of(context).pushNamedAndRemoveUntil(
//                 '/login_screen', (Route<dynamic> route) => false);
//           },
//         );
//       });
// }

// showErrorDialog(var message, BuildContext context) {
//   showDialog(
//       barrierDismissible: false, // user must tap button!
//       context: context,
//       builder: (_) {
//         return ResponseAlertDialog(
//           alertTitle: 'عفواً',
//           alertMessage: message,
//           alertBtn: 'موافق',
//           onPressedAlertBtn: () {},
//         );
//       });
// }

  static void showToast(
      {@required String message,
      @required BuildContext context,
      Color color,
      int duration = 3}) {
    return Toast.show(
      message,
      context,
      backgroundColor: color == null ? mainAppColor : color,
      duration: duration,
      gravity: Toast.BOTTOM,
    );
  }
}
