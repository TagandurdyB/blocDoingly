// ignore_for_file: must_be_immutable

part of 'list_bloc.dart';

abstract class ListState {
  List<ListModel> lists;
  ListState({required this.lists});
}

class ListInitial extends ListState {
  ListInitial({required List<ListModel> lists}) : super(lists: lists);
}

class ListUpdate extends ListState {
  ListUpdate({required List<ListModel> lists}) : super(lists: lists);
}
