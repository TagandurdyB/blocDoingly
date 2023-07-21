part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  final List<ListModel> lists;
  const ListState({required this.lists});

  @override
  List<Object> get props => [lists];
}

class ListInitial extends ListState {
  ListInitial({required List<ListModel> lists}) : super(lists: []);
}

class ListUpdate extends ListState {
  ListUpdate({required List<ListModel> lists}) : super(lists: []);
}
