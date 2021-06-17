import 'package:admin_app/custom_widget/custom_text/custom_text.dart';
import 'package:admin_app/locale/app_localizations.dart';
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldAuth extends StatelessWidget {
  final String text;
  final String hintText;
  final Function onChange;
  final Function validator;
  final bool obsecureText;

  const CustomTextFormFieldAuth(
      {Key key,
      this.text,
      this.hintText,
      this.onChange,
      this.obsecureText = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              color: mainAppColor,
              text: AppLocalizations.of(context).translate(text),
              fontSize: 12,
              fontWeight: FontWeight.w500),
          Container(
            child: TextFormField(
              onChanged: onChange,
              validator: validator,
              // autovalidate: true,
              // onEditingComplete: () => node.nextFocus(),
              textInputAction: TextInputAction.next,

              // onFieldSubmitted: (v) {
              //   FocusScope.of(context).requestFocus(node);
              // },
              decoration: InputDecoration(
                  isDense: true,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 10),
                  errorMaxLines: 3,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                  fillColor: Colors.white),
              obscureText: obsecureText,
            ),
          )
        ],
      ),
    );
  }
}
