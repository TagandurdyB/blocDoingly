part of 'task_bloc.dart';

abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;
  // final ListModel list;
  final int? listIndex;
  // final String name;
  AddTask({
    required this.task,
    // required this.list,
    this.listIndex,
  });
}

class ReadTask extends TaskEvent {
  // final TaskModel task;
  // ReadTask({required this.task});
}

class DeleteTask extends TaskEvent {
  final TaskModel task;
  // final ListModel list;
  final int? listIndex;
  // final String uuid;
  final int? index;
  DeleteTask({
    required this.task,
    // required this.list,
    required this.listIndex,
    this.index,
  });
}

class UpdateTask extends TaskEvent {
   TaskModel task;
  // final ListModel list;
  final int? listIndex;
  final int? index;
  UpdateTask({
    required this.task,
    // required this.list,
    required this.listIndex,
    this.index,
  });
}
