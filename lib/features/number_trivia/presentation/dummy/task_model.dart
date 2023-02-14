import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';
@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String task;

  

  Task({required this.task});
}
