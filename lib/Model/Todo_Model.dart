
import 'package:hive_ce_flutter/hive_flutter.dart';
part 'Todo_Model.g.dart';

@HiveType(typeId: 1)
class TaskModel{
  @HiveField(0)
String task ;
  @HiveField(1)
String timer;
  @HiveField(2)
bool isCompleted;
  @HiveField(3)
bool isOngoing;
TaskModel({ required this.task,required this.timer,this.isOngoing=false,this.isCompleted=false,});

  @override
  String toString() =>
      'TaskModel(task: $task, timer: $timer, isCompleted: $isCompleted, isOngoing: $isOngoing)';

}