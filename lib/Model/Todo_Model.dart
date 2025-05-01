
import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier{
String task ='';
String timer;
bool isCompleted;
bool isOngoing;
TaskModel({ required this.task,required this.timer,this.isOngoing=false,this.isCompleted=false,});

@override
String toString() {
  return 'TaskModel(task: $task, timer: $timer, isOngoing: $isOngoing)';
}
}