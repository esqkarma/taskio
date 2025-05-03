import 'dart:async';
import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier{


  Timer? timer;
  int remainingSeconds = 0;
  bool isRunning = false;
  bool isPaused = false;
  int totalSeconds=0;
  int remainingTimeVar = 0;

  void startTimer(int? inputTime,
      {VoidCallback? onLastTenSeconds,
        VoidCallback? timeOverSound,
        VoidCallback? taskComplition}) {
    if (isRunning) return;
    if (inputTime == null) return;

    remainingSeconds = inputTime;
    totalSeconds = remainingSeconds;
    if (remainingSeconds < 0) return;

    isRunning = true;
    isPaused = false;
    bool popupShown = false;

    timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        _timer.cancel();
        isRunning = false;
        notifyListeners();
      }

      if (remainingSeconds > 0 &&
          remainingSeconds <= 6 &&
          onLastTenSeconds != null) {
        onLastTenSeconds();
      }

      if (remainingSeconds == 0 && !popupShown) {
        if (timeOverSound != null) timeOverSound();
        if (taskComplition != null) taskComplition();
        popupShown = true; //
      }
      remainingTimeVar = totalSeconds-remainingSeconds;
    });

    notifyListeners();
  }

  void pauseTimer(){
    remainingTimeVar = totalSeconds-remainingTimeVar;
    timer?.cancel();
    isPaused=true;
    isRunning=false;
    notifyListeners();
  }





  void resumeTimer({VoidCallback? onLastTenSeconds,VoidCallback? timeOverSound, VoidCallback? taskComplition}){
    bool popupShown = false;
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
      if (remainingSeconds == 0 && !popupShown) {
        if (timeOverSound != null) timeOverSound();
        if (taskComplition != null) taskComplition();
        popupShown = true; //
      }
    });

  }

  void stopTimer(){
    timer?.cancel();
    isRunning=false;
    isPaused=false;
    remainingTimeVar = totalSeconds-remainingTimeVar;
    //if we make this variable 0 the user can complete the task by stopping the timer, we are using this variable in the conditional statement,
    //so they can only complete the task by doing it or waiting till the timer to set this variable to 0 automatically
    remainingSeconds=0;
    totalSeconds=0;
    notifyListeners();

  }
int remainingTime(){
    return remainingTimeVar;
}
}