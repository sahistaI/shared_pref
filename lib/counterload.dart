import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counterload extends StatefulWidget{
  @override
  State<Counterload> createState() => CounterloadState();
}

class CounterloadState extends State<Counterload> {

  int count = 0;
  Color randomColor = Colors.blueGrey;

  @override
  void initState(){
    super.initState();
    loadCounter();
    loadColor();

  }
  void loadCounter()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      count = prefs.getInt('counter') ?? 0;
  });
  }

  void increment() async{

    setState(() {
      count++;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', count);

    if(count % 3 == 0){
      randomColor = generateRandom();
    }

  }

  void loadColor () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('randomColor');
    if(colorValue != null){
      setState(() {
        randomColor = Color(colorValue);
      });

    }
  }

  void generateAndSave () async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('randomColor', randomColor.value);
    setState(() {
      randomColor = generateRandom();
    });

  }

  Color generateRandom (){

    Random random = Random();
    return Color.fromARGB(255, random.nextInt(255), random.nextInt(255),random.nextInt(255));



  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: randomColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(count.toString(),style: TextStyle(
                  fontSize: 35,fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 20,),
            FloatingActionButton(onPressed:increment,


              child: Icon(Icons.add,size: 25,),),

            SizedBox(height:30),

            Text('You have clicked $count no. of times',style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 15
            ),),


          ],
        ),
      ),
    );
  }
}