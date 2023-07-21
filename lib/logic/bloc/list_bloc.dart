import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/list_model.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListInitial(lists: const [])) {
    on<AddList>(_addList);
    on<ReadList>(_readList);
    on<DeleteList>(_deleteList);
    on<UpdateList>(_updateList);
  }

  void _addList(AddList event, Emitter<ListState> emit) {
    state.lists.add(event.list);
    emit(ListUpdate(lists: state.lists));
  }

    void _readList(ReadList event, Emitter<ListState> emit) {
    // state.lists.add(event.list);
    print("hello");
    emit(ListUpdate(lists: state.lists));
  }

  void _deleteList(DeleteList event, Emitter<ListState> emit) {
    state.lists.remove(event.list);
    emit(ListUpdate(lists: state.lists));
  }

  void _updateList(UpdateList event, Emitter<ListState> emit) {
    final index = event.index;
    state.lists[index] = event.list;
    emit(ListUpdate(lists: state.lists));
  }
}
