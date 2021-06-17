import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final String alertMessage;
  final String button1;
  final String button2;

  final Function onPressedConfirm;

  const LogoutDialog(
      {Key key,
      this.alertMessage,
      this.onPressedConfirm,
      this.button1,
      this.button2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              alertMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              color: Color(0xff707070),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(button2,
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500))),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.black,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onPressedConfirm();
                    },
                    child: Text(button1,
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)))
              ],
            )
          ],
        ),
      ),
    );
  
  
  }
}
