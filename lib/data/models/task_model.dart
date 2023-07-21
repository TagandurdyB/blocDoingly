import 'list_model.dart';

class TaskModel {
  final String name;
  final String uuid;
  final bool completed;
  final ListModel? list;

  TaskModel({
    required this.name,
    required this.uuid,
    required this.completed,
    this.list,
  });
}
