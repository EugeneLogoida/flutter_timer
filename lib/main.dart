import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TimerApp(),
    );
  }
}
class TimerApp extends StatefulWidget {
  const TimerApp({Key? key}) : super(key: key);

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  int sec = 0, min = 0, hrs = 0;
  String digitSec = "00", digitMin = "00", digitHrs = "00";
  Timer? timer;
  bool isStarted = false;
  List laps = [];

  void stopTimer(){
    timer!.cancel();
    setState(() {
      isStarted = false;
    });
  }
  void resetTimer(){
    timer!.cancel();
    setState(() {
      sec = 0;
      min = 0;
      hrs = 0;

      digitSec = "00";
      digitMin = "00";
      digitHrs = "00";

      isStarted = false;
    });
  }
  void addLap(){
    String lap = "$digitHrs:$digitMin:$digitSec";
    setState(() {
      laps.add(lap);
    });
  }
  void startTimer(){
    isStarted = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSec = sec + 1;
      int localMin = min;
      int localHrs = hrs;

      if(localSec>59){
        if(localMin>59){
          localHrs++;
          localMin = 0;
        }
        else{
          localMin++;
          localSec = 0;
        }
      }
      setState(() {
        sec = localSec;
        min = localMin;
        hrs = localHrs;
        digitSec = (sec>=10) ? "$sec":"0$sec";
        digitMin = (min>=10) ? "$min":"0$min";
        digitHrs = (hrs>=10) ? "$hrs":"0$hrs";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xDD4B92C4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                    "Секундомір",
                    style:TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "$digitHrs:$digitMin:$digitSec",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 82.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Коло №${index+1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text("${laps[index]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!isStarted) ? startTimer() : stopTimer();
                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        (!isStarted) ? "Старт" : "Пауза",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      addLap();
                    },
                    icon: Icon(Icons.flag),),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        resetTimer();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(),
                      child: Text("Обнулення",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

