import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_pref/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget{

  static const String LOGIN_KEY = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
        // if logged in sucessfully
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool(LOGIN_KEY, true);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));


          },
          child: Text(LOGIN_KEY),
        ),
      ),
    );
  }

}