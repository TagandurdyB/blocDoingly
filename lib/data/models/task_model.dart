import 'dart:convert';

import 'list_model.dart';

import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String uuid;
  @HiveField(2)
  final bool completed;
  @HiveField(3)
  final ListModel? list;
  @HiveField(4)
  final bool isConnect;
  @HiveField(5)
  final bool isEdit;

  TaskModel({
    required this.name,
    required this.uuid,
    required this.completed,
    this.isConnect = false,
    this.isEdit = false,
    this.list,
  });

  TaskModel copyWith({
    String? name,
    String? uuid,
    bool? completed,
    bool? isConnect,
    bool? isEdit,
    ListModel? list,
  }) {
    return TaskModel(
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
      completed: completed ?? this.completed,
      isConnect: isConnect ?? this.isConnect,
      isEdit: isEdit ?? this.isEdit,
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': name,
      'listUuid': uuid,
      'completed': completed,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      name: map['text'] ?? '',
      uuid: map['uuid'] ?? '',
      completed: map['completed'] ?? false,
      isConnect: true,
      list: map['List'] != null ? ListModel.fromMap(map['List']) : null,
    );
  }

  static List<TaskModel> fromList(List list) =>
      list.map((map) => TaskModel.fromMap(map)).toList();

  static List<List<TaskModel>> fromListAll(List jsonList) {
    Map<String, List<TaskModel>> map = {};
    String listName = "";
    for (int i = 0; i < jsonList.length; i++) {
      listName = jsonList[i]["List"]["name"];
      if (map[listName] != null) {
        map[listName]!.add(TaskModel.fromMap(jsonList[i]));
      } else {
        map.addAll({
          listName: [TaskModel.fromMap(jsonList[i])]
        });
      }
    }
    return map.values.toList();
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(name: $name, uuid: $uuid, completed: $completed, list: $list, isConnect: $isConnect, isEdit: $isEdit )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.name == name &&
        other.uuid == uuid &&
        other.completed == completed &&
        other.isConnect == isConnect &&
        other.isEdit == isEdit &&
        other.list == list;
  }

  @override
  int get hashCode {
    return name.hashCode ^ uuid.hashCode ^ completed.hashCode ^ list.hashCode;
  }
}
