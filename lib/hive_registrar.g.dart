// Generated by Hive CE
// Do not modify
// Check in to version control

import 'package:hive_ce/hive.dart';
import 'package:taskio/Model/Todo_Model.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(TaskModelAdapter());
  }
}

extension IsolatedHiveRegistrar on IsolatedHiveInterface {
  void registerAdapters() {
    registerAdapter(TaskModelAdapter());
  }
}
