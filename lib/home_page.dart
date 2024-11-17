import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_pref/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => HomaPageState();

}
class HomaPageState extends State<HomePage>{

  var nameController = TextEditingController();
  String name ="";
  int count = 0;

  @override
  void initState(){
    super.initState();

    // value fetch
    getValueFromPrefs();
    manageCount();

  }

  void getValueFromPrefs() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "";
    setState(() {

    });

  }

  void manageCount() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    count = prefs.getInt("count") ?? 0;

    count ++;

    prefs.setInt("count", count);

    setState(() {

    });





  }




  @override
  Widget build(BuildContext context) {

   return Scaffold(
     backgroundColor: count % 3 == 0 ? Colors.primaries[Random().nextInt(Colors.primaries.length)]: Colors.white,
     appBar: AppBar(
       title: Text('Home'),
     ),

     body: Column(
       children: [
         Text(name!="" ? 'Welcome , $name' : ""),
         TextField(
           controller:nameController,
         ),

         Text("You have open app $count times"),

         ElevatedButton(onPressed: () async {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("name",nameController.text);

         }, child: Text('Save')),

         ElevatedButton(onPressed: () async {

           SharedPreferences prefs = await SharedPreferences.getInstance();
           await prefs.setBool(LoginPage.LOGIN_KEY, false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));

         }, child: Text('Logout'))


       ],
     )


   );
  }

}