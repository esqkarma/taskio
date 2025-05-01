import 'dart:async';
import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier{


  Timer? timer;
  int remainingSeconds = 0;
  bool isRunning = false;
  bool isPaused = false;
  int totalSeconds=0;

  void startTimer(int? inputTime,{VoidCallback? onLastTenSeconds,VoidCallback? timeOver}){

    if(isRunning) return;
    if(inputTime == null ) return;
    remainingSeconds = inputTime;
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
      if(remainingSeconds==6 && onLastTenSeconds != null)
        {
          onLastTenSeconds();
          notifyListeners();
        }
      else
        if(remainingSeconds==0 && timeOver != null )
          {
            timeOver();
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
  void resumeTimer({VoidCallback? onLastTenSeconds,VoidCallback? timeOver}){
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
      if(remainingSeconds>0&& remainingSeconds<=6 && onLastTenSeconds != null)
      {


            onLastTenSeconds();
            notifyListeners();


      }
      else
      if(remainingSeconds==0 && timeOver != null )
      {
        timeOver();
        notifyListeners();

      }
    });

  }

  void stopTimer(){
    timer?.cancel();
    isRunning=false;
    isPaused=false;
    //if we make this variable 0 the user can complete the task by stopping the timer, we are using this variable in the conditional statement,
    //so they can only complete the task by doing it or waiting till the timer to set this variable to 0 automatically
    remainingSeconds=1;
    totalSeconds=0;
    notifyListeners();

  }

}