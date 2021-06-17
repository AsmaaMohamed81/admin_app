
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color borderColor;
  final Color btnColor;
  final String btnLbl;
  final Function onPressedFunction;
  final TextStyle btnStyle;


  const CustomButton(
      {Key key,
      this.btnLbl,
      this.onPressedFunction,
      this.btnColor,
      this.borderColor,
      this.btnStyle,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        return  Container(
        height: constraints.maxHeight,
        margin: EdgeInsets.symmetric(
            horizontal:
               constraints.maxWidth* 0.05,
            vertical: constraints.maxHeight * 0.01),
        child: Builder(
            builder: (context) => RaisedButton(
                  onPressed: () {
                    onPressedFunction();
                  },
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                       side: BorderSide(color:borderColor != null ?
                        borderColor : mainAppColor  )
                      ),
                  color: btnColor != null
                      ? btnColor
                      : Theme.of(context).primaryColor,
                  child: Container(
                      alignment: Alignment.center,
                      child: new Text(
                        '$btnLbl',
                        style: btnStyle == null
                            ? Theme.of(context).textTheme.button
                            : btnStyle,
                      )),
                )));
      }
    );
  }
}
