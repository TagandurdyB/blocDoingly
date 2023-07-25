// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';

import '../../config/hive_boxes.dart';
import '../../data/models/list_model.dart';
import '../../data/models/response_model.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import '../cubit/internet_cubit.dart';
import 'list_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final InternetCubit internet;
  final TaskRepository repository;
  final ListBloc listBloc;
  TaskBloc(this.internet, this.repository, this.listBloc)
      : super(TaskInitial(tasks: []));

  final box = Boxes.hiveTasks();
  final boxDeleted = Boxes.hiveTasksDelete();

  Future<ResponseModel> addTask(AddTask event) async {
    if (internet.state is InternetConnected) {
      final either = await repository.create(event.task);
      if (either.isRight) {
        state.tasks.add(either.right);
        listBloc.incrementTask(event.listIndex!);
        emit(TaskUpdate(tasks: state.tasks));
        return ResponseModel(status: true, message: "Success");
      } else {
        return either.left;
      }
    } else {
      Boxes.changeMigrate(true);
//==================
      final hiveTasks = box.get(event.listIndex!);
      if (hiveTasks != null) {
        state.tasks = hiveTasks.map((e) => e as TaskModel).toList();
      } else {
        state.tasks = [];
      }
//==================
      state.tasks.add(event.task);
      listBloc.incrementTask(event.listIndex!);
      box.put(event.listIndex!, state.tasks);
      emit(TaskUpdate(tasks: state.tasks));
      return ResponseModel(status: true, message: "Task Added local base!");
    }
  }

  Future<void> readTask(String listUuid, int listIndex) async {
    emit(TaskInitial(tasks: []));
    if (internet.state is InternetConnected) {
      print("Read from Internet");
      state.tasks = await repository.read(listUuid);
      box.put(listIndex, state.tasks);
    } else {
      print("Read from Hive");
      try {
        final hiveTasks = box.get(listIndex);
        if (hiveTasks != null) {
          state.tasks = hiveTasks.map((e) => e as TaskModel).toList();
        } else {
          state.tasks = [];
        }
      } catch (e) {
        print(
            "error:=$e  $listIndex   ${box.keys.toList().reversed}    ${box.get(listIndex)} ");
        state.tasks = [];
      }
    }
    emit(TaskUpdate(tasks: state.tasks));
  }

  Future<void> readAll() async {
    state.tasksAll = await repository.readAll();
    emit(TaskUpdate(tasks: state.tasks, tasksAll: state.tasksAll));
  }


  Future<ResponseModel> deleteTask(DeleteTask event) async {
    if (internet.state is InternetConnected) {
      final response = await repository.delete(event.task.uuid);
      if (response.status) {
        state.tasks.remove(event.task);
        emit(TaskUpdate(tasks: state.tasks));
      }
      listBloc.decrementTask(event.listIndex!);
      return response;
    } else {
      Boxes.changeMigrate(true);
      listBloc.decrementTask(event.listIndex!);
      state.tasks.remove(event.task);
      //================
      List hiveDeletList = boxDeleted.get(event.listIndex) ?? [];
      hiveDeletList.add(event.task);
      boxDeleted.put(event.listIndex, hiveDeletList);
      //================
      box.put(event.listIndex, state.tasks);
      emit(TaskUpdate(tasks: state.tasks));
      return ResponseModel(
          status: true, message: "Task deleted from local base!");
    }
  }

  Future<void> updateTaskState(UpdateTask event) async {
    if (event.index != null) {
      state.tasks[event.index!] = event.task;
    } else {
      for (int i = 0; i < state.tasks.length; i++) {
        if (state.tasks[i].uuid == event.task.uuid) {
          state.tasks[i] = event.task;
          break;
        }
      }
    }
    listBloc.updateComplated(event.listIndex!, event.task.completed);
    emit(TaskUpdate(tasks: state.tasks));
  }

  Future<ResponseModel> updateTask(UpdateTask event) async {
    if (internet.state is InternetConnected) {
      final response = await repository.update(event.task);
      if (response.status) {
        updateTaskState(event);
      }
      return response;
    } else {
      Boxes.changeMigrate(true);
      event.task=event.task.copyWith(isConnect: false, isEdit:event.task.isConnect);
      var hiveTasks = box.get(event.listIndex!) ?? [];
      hiveTasks[event.index!]=event.task;
      box.put(event.listIndex, hiveTasks);
      updateTaskState(event);
      return ResponseModel(
          status: true, message: "Task Updated from local base!");
    }
  }
}
