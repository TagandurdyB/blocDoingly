// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';

import '../../data/models/list_model.dart';
import '../../data/models/response_model.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import 'list_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
  final ListBloc listBloc;
  TaskBloc(this.repository, this.listBloc) : super(TaskInitial(tasks: []));

  Future<ResponseModel> addTask(AddTask event) async {
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
  }

  Future<void> readTask(String listUuid) async {
    state.tasks = await repository.read(listUuid);
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
    final response = await repository.delete(event.task.uuid);
    if (response.status) {
      state.tasks.remove(event.task);
      emit(TaskUpdate(tasks: state.tasks));
    }
    listBloc.decrementTask(event.listIndex!);
    return response;
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
    final response = await repository.update(event.task);
    if (response.status) {
      updateTaskState(event);
    }
    return response;
  }
}
