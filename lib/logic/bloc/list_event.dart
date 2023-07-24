part of 'list_bloc.dart';

abstract class ListEvent {}

class AddList extends ListEvent {
  // final ListModel list;
  final String name;
  AddList({required this.name});
}

class ReadList extends ListEvent {
  // final ListModel list;
  // ReadList({required this.list});
}

class DeleteList extends ListEvent {
  final ListModel list;
  final int? index;
  DeleteList({required this.list, this.index});
}

class UpdateList extends ListEvent {
   ListModel list;
  final int? index;
  UpdateList({required this.list, this.index});
}
