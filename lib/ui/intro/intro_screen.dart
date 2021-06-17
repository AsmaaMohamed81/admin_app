
import 'package:admin_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
    double _height =0, _width =0;

  Widget _buildBodyItem(){
    return Stack(

      children: <Widget>[
        Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/intro_bg.png"),
            fit: BoxFit.cover,
          ),
        )),
         Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Rectangle.png"),
            fit: BoxFit.cover,
          ),
        )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: _height *0.25,
            ),
     Container(
       alignment: Alignment.center,
       child:      Image.asset('assets/images/logo.png',height: 200,),
     ),
  
     Container(

       alignment: Alignment.center,
       margin: EdgeInsets.symmetric(horizontal: _width *0.05),
       child: Text('A brand new experience to learn something new. Polish your skills with this app. Easy to use.',
       style: TextStyle(
         color: Colors.white
       ),
       textAlign: TextAlign.center,
       ),
     ),
     Container(
        height: 55,
        margin: EdgeInsets.symmetric(
            horizontal:
               _width * 0.15,
            vertical:20),
        child: Builder(
            builder: (context) => RaisedButton(
                  onPressed:()=>
                   Navigator.pushReplacementNamed(context,'/login_screen')
                  ,
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  color: Colors.white,
                  child: Container(
                      alignment: Alignment.center,
                      child: new Text('Lets Get Started!',
                      style: TextStyle(
                        color: mainAppColor,fontSize: 17
                      ),
                      )
                      )),
                ))
          ],
        )
      ],
    );
  }  
  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _buildBodyItem(),
    );
  }
}