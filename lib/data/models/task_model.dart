import 'dart:convert';

import 'list_model.dart';

class TaskModel {
  final String name;
  final String uuid;
  final bool completed;
  final ListModel? list;

  TaskModel({
    required this.name,
    required this.uuid,
    required this.completed,
    this.list,
  });

  TaskModel copyWith({
    String? name,
    String? uuid,
    bool? completed,
    ListModel? list,
  }) {
    return TaskModel(
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
      completed: completed ?? this.completed,
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
    return 'TaskModel(name: $name, uuid: $uuid, completed: $completed, list: $list)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.name == name &&
        other.uuid == uuid &&
        other.completed == completed &&
        other.list == list;
  }

  @override
  int get hashCode {
    return name.hashCode ^ uuid.hashCode ^ completed.hashCode ^ list.hashCode;
  }
}
