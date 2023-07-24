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

  Future<ResponseModel> addTask(AddTask event) async {
    if (internet.state is InternetConnected) {
      final either = await repository.create(event.task);
      if (either.isRight) {
        state.tasks.add(either.right);
        // listBloc.updateListState(UpdateList(
        //     list: event.list.copyWith(taskCount: event.list.taskCount + 1)));
        // listBloc.addTask(UpdateList(list: event.list));
        listBloc.incrementTask(event.listIndex!);
        emit(TaskUpdate(tasks: state.tasks));
        return ResponseModel(status: true, message: "Success");
      } else {
        return either.left;
      }
    } else {
      Boxes.changeMigrate(true);
      state.tasks = box.get(event.listIndex!) ?? [];
      box.put(event.listIndex!, state.tasks);
      print("jsdfhsl dfkasj:=${event.listIndex}");
      state.tasks.add(event.task);
      // state.tasks = box.values.toList();
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
      // state.tasks = box.get(event.listIndex!) ?? [];
      // final boxTasks = box.getAt(listIndex) ?? [];
      // for (int i = 0; i < state.tasks.length; i++) {
      //   // box.put(i, state.tasks[i]);
      //   // boxTasks.
      // }
    } else {
      print("Read from Hive");
      try {
        // final List<List<TaskModel>> tasksByList = box.values.toList();
        // final int key = box.keys.toList()[listIndex] as int;
        // print("jsdfhsl dfkasj:=${box.keys.toList()}  $key");
        // state.tasks = tasksByList[key];
        state.tasks = box.get(listIndex) ?? [];
      } catch (e) {
        print("error:=$e  $listIndex   ${box.keys.toList()}");
        state.tasks = [];
      }
    }
    emit(TaskUpdate(tasks: state.tasks));
  }

  Future<void> readAll() async {
    state.tasksAll = await repository.readAll();
    emit(TaskUpdate(tasks: state.tasks, tasksAll: state.tasksAll));
  }
  // Future<void> readList(ReadList event, Emitter<ListState> emit) async {
  //   state.tasks = await repository.read();
  //   emit(TaskUpdate(tasks: state.tasks));
  // }

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
      box.delete(event.task);
      state.tasks = box.values.toList()[event.listIndex!];
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
    // listBloc.updateListState(UpdateList(
    //     list: event.list.copyWith(completed: event.list.completed + 1)));
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
      return ResponseModel(
          status: true, message: "Task Updated from local base!");
    }
  }
}
