import 'package:flutter/material.dart';

import '../Model/Todo_Model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> taskTable = [];

  List<TaskModel> get task => taskTable;

  //This function is used to change the Ongoing criteria of a task.
  //Going to use this function in the upcoming task section,
  // whenever user clicks on top of a task the Ongoing variable will change to true
  //and task will be in OnGoing Task Card/section
  //29/04/25
  //Now the function will return  bool value (True=> if there an onGoing task available,
  //False=> If the task is added to ongoing section).

  bool setTaskOnGoingStatus(int index) {
    //This will check any ongoing task is active
    bool isAnyTaskOngoing = task.any((task) => task.isOngoing);
    if (isAnyTaskOngoing) {
      return isAnyTaskOngoing;
    } else {
      final data = task[index];
      data.isOngoing = true;
      notifyListeners();
      return false;
    }
  }
  void setTaskCompletedStatus(int index) {

      final data = task[index];
      data.isCompleted = true;
      data.isOngoing=false;
      notifyListeners();


  }

  void addTask(String task, String time, {bool isOngoing = false,bool isCompleted =false}) {
    TaskModel taskmodel =
        TaskModel(task: task, timer: time, isOngoing: isOngoing,isCompleted: isCompleted);
    taskTable.add(taskmodel);
    print(taskTable);
    notifyListeners();
  }

  void removeTask(int index) {
    taskTable.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index, String taskName, String time,
      {bool isOngoing = false,bool isCompleted = false}) {
    final data = task[index];
    data.task = taskName;
    data.timer = time;
    data.isOngoing = isOngoing;
    data.isCompleted = isCompleted;
    notifyListeners();
  }
}
