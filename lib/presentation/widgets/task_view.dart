import 'package:flutter/material.dart';

// import '../../../domain/entities/list_entity.dart';
// import '../../../domain/entities/task_entity.dart';
import '../../data/models/list_model.dart';
import '../../data/models/task_model.dart';
import 'task_card.dart';

class TaskView extends StatelessWidget {
  final List<TaskModel> objs;
  final ListModel listObj;
  final int listIndex;
  final Function? cardFunc;

  const TaskView({
    required this.objs,
    required this.listObj,
    required this.listIndex,
    this.cardFunc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Widget buildContent() {
    return Column(
      children: List.generate(objs.length + 2, (index) {
        if (index != 0 && index - 1 < objs.length) {
          return TaskCard(
            obj: objs[index - 1],
            index: index - 1,
            listIndex: listIndex,
            onTab: cardFunc,
          );
        } else if (index == 0) {
          return buildTist();
        } else {
          return const SizedBox(height: 80);
        }
      }),
    );
  }

  Widget buildTist() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("List : ${listObj.name}", style: const TextStyle(fontSize: 20)),
          Text("Tasks: ${objs.length}", style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
