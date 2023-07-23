import 'dart:convert';

class ListModel {
  final String name;
  final String uuid;
  final int taskCount;
  final int completed;
  final bool isConnect;

  ListModel({
    required this.name,
    required this.uuid,
    required this.isConnect,
    this.taskCount = 0,
    this.completed = 0,
  });

  ListModel copyWith({
    String? name,
    String? uuid,
    int? taskCount,
    bool? isConnect,
    int? completed,
  }) {
    return ListModel(
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
      isConnect: isConnect ?? this.isConnect,
      taskCount: taskCount ?? this.taskCount,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uuid': uuid,
      'taskCount': taskCount,
      'completed': completed,
    };
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      name: map['name'] ?? '',
      uuid: map['uuid'] ?? '',
      isConnect: true,
      taskCount: int.parse("${map['taskCount'] ?? "0"}"),
      completed: int.parse("${map['completedTaskCount'] ?? "0"}"),
    );
  }

  static List<ListModel> fromList(List list) =>
      list.map((map) => ListModel.fromMap(map)).toList();

  String toJson() => json.encode(toMap());

  factory ListModel.fromJson(String source) =>
      ListModel.fromMap(json.decode(source));

  static List<ListModel> fromJsonList(String source) {
    try {
      return ListModel.fromList(json.decode(source));
    } catch (e) {
      throw "Error in ListModel>fromJsonList : ${json.decode(source)}  err:$e";
    }
  }

  @override
  String toString() {
    return 'ListModel(name: $name, uuid: $uuid, taskCount: $taskCount, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListModel &&
        other.name == name &&
        other.uuid == uuid &&
        other.taskCount == taskCount &&
        other.completed == completed;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uuid.hashCode ^
        taskCount.hashCode ^
        completed.hashCode;
  }
}
