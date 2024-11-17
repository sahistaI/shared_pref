import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter extends StatefulWidget{
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  int count = 0;

 Color randomColor = Colors.blue;

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

  void loadColor() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('randomColor');
    if(colorValue!= null){
      setState(() {
        randomColor = Color(colorValue);
      });
    }
  }

  void generateAndSaveColor ()async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('randomColor', randomColor.value);
    setState(() {
      randomColor = generateRandom();
    });
  }

  Color generateRandom(){
    Random random = Random();
    return Color.fromARGB(255, random.nextInt(256),
          random.nextInt(256),random.nextInt(256));
  }


  void incrementCounter() async{

    setState(() {
      count++;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', count);

    if (count % 3 == 0){
      generateAndSaveColor();
    }

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
            FloatingActionButton(onPressed: incrementCounter,

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