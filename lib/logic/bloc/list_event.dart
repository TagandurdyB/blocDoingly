part of 'list_bloc.dart';

abstract class ListEvent {}

class AddList extends ListEvent {
  final ListModel list;
  AddList({required this.list});
}

class ReadList extends ListEvent {
  // final ListModel list;
  // ReadList({required this.list});
}

class DeleteList extends ListEvent {
  final ListModel list;
  DeleteList({required this.list});
}

class UpdateList extends ListEvent {
  final ListModel list;
  final int index;
  UpdateList({required this.list, required this.index});
}
