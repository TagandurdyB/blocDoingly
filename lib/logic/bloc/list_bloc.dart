// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';

import '../../data/models/list_model.dart';
import '../../data/models/response_model.dart';
import '../../data/repositories/list_repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ListRepository repository;
  // final 
  ListBloc(this.repository) : super(ListInitial(lists: const [])) {
    // on<ReadList>(_readList);
    // on<DeleteList>(_deleteList);
    // on<UpdateList>(_updateList);
  }

  Future<ResponseModel> addList(AddList event) async {
    final either = await repository.create(event.name);
    if (either.isRight) {
      state.lists.add(either.right);
      emit(ListUpdate(lists: state.lists));
      return ResponseModel(status: true, message: "Success");
    } else {
      return either.left;
    }
  }

  Future<void> readList() async {
    state.lists = await repository.read();
    emit(ListUpdate(lists: state.lists));
  }

  // Future<void> readList(ReadList event, Emitter<ListState> emit) async {
  //   state.lists = await repository.read();
  //   emit(ListUpdate(lists: state.lists));
  // }

  Future<ResponseModel> deleteList(DeleteList event) async {
    final response = await repository.delete(event.list.uuid);
    if (response.status) {
      state.lists.remove(event.list);
      emit(ListUpdate(lists: state.lists));
    }
    return response;
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
    final response = await repository.update(event.list);
    if (response.status) {
      updateListState(event);
    }
    return response;
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
