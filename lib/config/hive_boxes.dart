import 'tags.dart';
import 'package:hive/hive.dart';

import '../data/models/list_model.dart';
import '../data/models/task_model.dart';

class Boxes {
  static Box<ListModel> hiveLists() => Hive.box<ListModel>(Tags.hiveList);
  // static Box<ListModel> hiveListsAdd() => Hive.box<ListModel>(Tags.hiveListAdd);
  // static Box<ListModel> hiveListsEdit() =>
  //     Hive.box<ListModel>(Tags.hiveListEdit);
  static Box<ListModel> hiveListsDelete() =>
      Hive.box<ListModel>(Tags.hiveListDelete);

  static Box<List> hiveTasks() =>
      Hive.box<List>(Tags.hiveTask);
  // static Box<TaskModel> hiveTasksAdd() =>
  //     Hive.box<TaskModel>(Tags.hiveTaskAdd);
  // static Box<TaskModel> hiveTasksEdit() =>
  //     Hive.box<TaskModel>(Tags.hiveListEdit);
  static Box<List> hiveTasksDelete() =>
      Hive.box<List>(Tags.hiveTaskDelete);

  static Box base() => Hive.box(Tags.hiveBase);
  static bool? get isMigrate => base().get(Tags.hiveIsMigrate);

  static void changeMigrate(bool isMigrate) =>
      base().put(Tags.hiveIsMigrate, isMigrate);

  // static Box<String> getSearchs() => Hive.box<String>(Tags.hiveSearchs);
}
