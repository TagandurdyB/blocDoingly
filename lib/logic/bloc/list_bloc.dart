// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';

import '../../config/hive_boxes.dart';
import '../../data/models/list_model.dart';
import '../../data/models/response_model.dart';
import '../../data/repositories/list_repository.dart';
import '../cubit/internet_cubit.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final InternetCubit internet;
  final ListRepository repository;
  // final
  ListBloc(this.internet, this.repository)
      : super(ListInitial(lists: const [])) {
    // on<ReadList>(_readList);
    // on<DeleteList>(_deleteList);
    // on<UpdateList>(_updateList);
  }

  final box = Boxes.hiveLists();
  final boxDelete = Boxes.hiveListsDelete();

  Future<ResponseModel> addList(AddList event) async {
    if (internet.state is InternetConnected) {
      final either = await repository.create(event.name);
      if (either.isRight) {
        state.lists.add(either.right);
        emit(ListUpdate(lists: state.lists));
        return ResponseModel(status: true, message: "Success");
      } else {
        return either.left;
      }
    } else {
      Boxes.changeMigrate(true);
      final model = ListModel(name: event.name, uuid: "", isConnect: false);
      box.add(model);
      state.lists.add(model);
      emit(ListUpdate(lists: state.lists));
      return ResponseModel(status: true, message: "List Added Local base!");
    }
  }

  Future<void> readList() async {
    if (internet.state is InternetConnected) {
      print("Read from Internet");
      state.lists = await repository.read();
      for (int i = 0; i < state.lists.length; i++) {
        box.put(i, state.lists[i]);
      }
    } else {
      state.lists = box.values.toList();
      print("Read from Hive");
    }
    emit(ListUpdate(lists: state.lists));
  }


  Future<ResponseModel> deleteList(DeleteList event) async {
    if (internet.state is InternetConnected) {
      final response = await repository.delete(event.list.uuid);
      if (response.status) {
        boxDelete.add(event.list.copyWith());
        state.lists.remove(event.list);
        emit(ListUpdate(lists: state.lists));
      }
      return response;
    } else {
      // box.deleteAt(event.list);
      if (event.list.taskCount == 0) {
        boxDelete.add(event.list.copyWith());
        event.list.delete();
        state.lists.remove(event.list);
        // state.lists=box.values.toList();
        emit(ListUpdate(lists: state.lists));
        return ResponseModel(
            status: true, message: "List deleted from local base!");
      } else {
        return ResponseModel(
            status: true,
            message: "List can not deleted! Because there is a task in it.");
      }
    }
  }

  Future<void> updateListState(UpdateList event) async {
    if (event.index != null) {
      state.lists[event.index!] = event.list;
    } else {
      for (int i = 0; i < state.lists.length; i++) {
        if (state.lists[i].uuid == event.list.uuid) {
          state.lists[i] = event.list;
          break;
        }
      }
    }
    emit(ListUpdate(lists: state.lists));
  }

  Future<ResponseModel> updateList(UpdateList event) async {
    if (internet.state is InternetConnected) {
      final response = await repository.update(event.list);
      if (response.status) {
        updateListState(event);
      }
      box.putAt(event.index!, event.list);
      return response;
    } else {
      event.list = event.list.copyWith(isConnect: false, isEdit: true);
      box.putAt(event.index!, event.list);
      updateListState(event);
      return ResponseModel(
          status: true, message: "List Updated from local base!");
    }
  }

  //Tasks==================================================
  void incrementTask(int i) {
    state.lists[i] =
        state.lists[i].copyWith(taskCount: state.lists[i].taskCount + 1);
    box.put(i, state.lists[i]);
    emit(ListUpdate(lists: state.lists));
  }

  void decrementTask(int i) {
    state.lists[i] =
        state.lists[i].copyWith(taskCount: state.lists[i].taskCount - 1);
    box.put(i, state.lists[i]);
    emit(ListUpdate(lists: state.lists));
  }

  void updateComplated(int i, bool isCheck) {
    state.lists[i] = state.lists[i]
        .copyWith(completed: state.lists[i].completed + (isCheck ? 1 : -1));
    box.put(i, state.lists[i]);
    emit(ListUpdate(lists: state.lists));
  }
}
