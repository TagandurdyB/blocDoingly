part of 'task_bloc.dart';

abstract class TaskState {
  List<TaskModel> tasks;
  List<List<TaskModel>>? tasksAll;
  ListModel? list;
  List<List<ListModel>>? listAll;
  // int? listIndex;
  TaskState(
      {required this.tasks, required this.list, this.tasksAll, this.listAll});
}

class TaskInitial extends TaskState {
  TaskInitial(
      {required List<TaskModel> tasks,
      ListModel? list,
      List<List<TaskModel>>? tasksAll})
      : super(tasks: tasks, list: list, tasksAll: tasksAll);
}

class TaskUpdate extends TaskState {
  TaskUpdate(
      {required List<TaskModel> tasks,
      ListModel? list,
       List<List<ListModel>>? listAll,
      List<List<TaskModel>>? tasksAll})
      : super(tasks: tasks, list: list,listAll: listAll, tasksAll: tasksAll);
}
