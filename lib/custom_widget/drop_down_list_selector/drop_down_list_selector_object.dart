import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DropDownListSelectorObject extends StatefulWidget {
  final List<Object> dropDownList;
  final String hint;
  final value;
  final Function onChangeFunc;
  final Function validationFunc;
  final bool elementHasDefaultMargin;
  final String validatemessage;

  const DropDownListSelectorObject(
      {Key key,
      this.dropDownList,
      this.hint,
      this.value,
      this.onChangeFunc,
      this.validationFunc,
      this.elementHasDefaultMargin: true,
      this.validatemessage})
      : super(key: key);
  @override
  _DropDownListSelectorObjectState createState() =>
      _DropDownListSelectorObjectState();
}

class _DropDownListSelectorObjectState
    extends State<DropDownListSelectorObject> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        margin: widget.elementHasDefaultMargin
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03)
            : EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: hintColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<dynamic>(
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red, fontSize: 8),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            validator: (value) => value == null ? widget.validatemessage : null,
            isExpanded: true,
            hint: Text(
              widget.hint,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'IBMPlexSans'),
            ),
            focusColor: mainAppColor,
            icon: Icon(
              Icons.arrow_drop_down,
              color: hintColor,
            ),
            style: TextStyle(
                fontSize: 12,
                color: mainAppColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'IBMPlexSans'),
            items: widget.dropDownList,
            onChanged: widget.onChangeFunc,
            value: widget.value,
          ),
        ));
  }
}
