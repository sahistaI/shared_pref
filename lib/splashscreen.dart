import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_pref/home_page.dart';
import 'package:shared_pref/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget{
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),() async{
      // Navigate to

      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool check = prefs.getBool(LoginPage.LOGIN_KEY) ?? false;

     /*if(check){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
     }else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
     }*/

      Widget navigateTo = LoginPage();

      if (check){
        navigateTo = HomePage();
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>navigateTo));




    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: FlutterLogo(size: 200,)),
    );
  }
}