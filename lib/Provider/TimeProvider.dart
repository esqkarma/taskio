import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskio/Model/Todo_Model.dart';
import 'package:taskio/Provider/TaskProvider.dart';

class TimeProvider extends ChangeNotifier{


  Timer? timer;
  int remainingSeconds = 0;
  bool isRunning = false;
  bool isPaused = false;
  int totalSeconds = 0;

  void startTimer(int? inputTime){

    if(isRunning) return;
    if(inputTime == null ) return;
    remainingSeconds = inputTime*60;
    totalSeconds = remainingSeconds;
    if(remainingSeconds<0) return;
    isRunning=true;
    isPaused =false;
    timer = Timer.periodic(Duration(seconds: 1), (_timer){
      if(remainingSeconds>0)
        {
          remainingSeconds--;
          notifyListeners();
        }
      else
        {
          _timer.cancel();
          isRunning=false;
          notifyListeners();
        }
    });
    notifyListeners();
  }

  void pauseTimer(){
    timer?.cancel();
    isPaused=true;
    isRunning=false;
    notifyListeners();
  }
  void resumeTimer(){
    if(remainingSeconds>0)
      {
        isPaused=false;
        isRunning=true;
        notifyListeners();
      }
    timer = Timer.periodic(Duration(seconds: 1), (_timer){
      if(remainingSeconds>0)
        {
          remainingSeconds--;
          notifyListeners();
        }
      else
        {
          timer?.cancel();
          isRunning=false;
          notifyListeners();
        }
    });

  }

  void stopTimer(){
    timer?.cancel();
    isRunning=false;
    isPaused=false;
    remainingSeconds=0;
    notifyListeners();

  }

}