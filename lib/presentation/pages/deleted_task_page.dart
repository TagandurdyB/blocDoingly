// ignore_for_file: must_be_immutable

import 'package:doingly/presentation/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config/hive_boxes.dart';
import '../../config/tags.dart';
import '../../data/models/task_model.dart';
import '../routes/rout.dart';

class DeletedTaskPage extends StatelessWidget {
  DeletedTaskPage({super.key});

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deleted Tasks"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: ValueListenableBuilder<Box<List<TaskModel>>>(
        valueListenable: Boxes.hiveTasksDelete().listenable(),
        builder: (context, box, _) {
          final lists = box.values.toList();
          final keys = box.keys.toList();
          if (lists.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.orange),
              // children: List,
              itemCount: keys.length + 1,
              itemBuilder: (context, indexK) {
                if (indexK < keys.length) {
                  return Column(
                    children: List.generate(lists[indexK].length, (index) {
                      return TaskCard(
                        // isReload: true,
                        obj: lists[indexK][index],
                        listIndex: keys[indexK],
                        index: index,
                        onTab: () {
                          // box.values.toList()[index].delete();
                        },
                      );
                    }),
                    // children: [
                    //   TaskCard(
                    //     // isReload: true,
                    //     obj: lists[index],
                    //     listIndex: ,
                    //     index: index,
                    //     onTab: () {
                    //       // box.values.toList()[index].delete();
                    //     },
                    //   ),
                    // ],
                  );
                } else {
                  return const SizedBox(height: 70);
                }
              },
            );
          } else {
            return const Center(child: Text("Recycle bin is empty!"));
          }
        },
      ),
    );
  }

  void _logOut() {
    final myBase = Hive.box(Tags.hiveBase);
    myBase.put(Tags.hiveToken, null);
    myBase.put(Tags.hiveIsLogin, false);
    Navigator.pushNamedAndRemoveUntil(context, Rout.login, (route) => false);
  }
}
