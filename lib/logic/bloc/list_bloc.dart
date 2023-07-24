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
  // final boxAdd = Boxes.hiveListsAdd();
  // final boxEdit = Boxes.hiveListsEdit();
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
      // boxAdd.add(model.copyWith());
      state.lists.add(model);
      // state.lists = box.values.toList();
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

  // Future<void> readList(ReadList event, Emitter<ListState> emit) async {
  //   state.lists = await repository.read();
  //   emit(ListUpdate(lists: state.lists));
  // }

  Future<ResponseModel> deleteList(DeleteList event) async {
    if (internet.state is InternetConnected) {
      final response = await repository.delete(event.list.uuid);
      if (response.status) {
        state.lists.remove(event.list);
        emit(ListUpdate(lists: state.lists));
      }
      return response;
    } else {
      // box.deleteAt(event.list);
      boxDelete.add(event.list.copyWith());
      event.list.delete();
      state.lists.remove(event.list);
      // state.lists=box.values.toList();
      emit(ListUpdate(lists: state.lists));
      return ResponseModel(
          status: true, message: "List deleted from local base!");
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
      event.list = event.list.copyWith(isConnect: false, isEdit: false);
      box.putAt(event.index!, event.list);
      // boxEdit.put(event.index!, event.list.copyWith());
      updateListState(event);
      return ResponseModel(
          status: true, message: "List Updated from local base!");
    }
  }

  //Tasks==================================================
  void incrementTask(int i) {
    state.lists[i] =
        state.lists[i].copyWith(taskCount: state.lists[i].taskCount + 1);
    emit(ListUpdate(lists: state.lists));
  }

  void decrementTask(int i) {
    state.lists[i] =
        state.lists[i].copyWith(taskCount: state.lists[i].taskCount - 1);
    emit(ListUpdate(lists: state.lists));
  }

  void updateComplated(int i, bool isCheck) {
    state.lists[i] = state.lists[i]
        .copyWith(completed: state.lists[i].completed + (isCheck ? 1 : -1));
    emit(ListUpdate(lists: state.lists));
  }
}
