// ignore_for_file: must_be_immutable

import 'package:doingly/data/models/list_model.dart';
import 'package:doingly/presentation/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config/hive_boxes.dart';
import '../../config/tags.dart';
import '../routes/rout.dart';

class DeletedListPage extends StatelessWidget {
  DeletedListPage({super.key});

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deleted Lists"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: ValueListenableBuilder<Box<ListModel>>(
        valueListenable: Boxes.hiveListsDelete().listenable(),
        builder: (context, box, _) {
          final list = box.values.toList();
          if (list.isNotEmpty) {
            return ListView.builder(
              itemCount: list.length + 1,
              itemBuilder: (context, index) {
                if (index < list.length) {
                  return ListCard(
                    isReload: true,
                    obj: list[index],
                    index: index,
                    onTab: () {},
                    onFirst: (){},
                    onSecond: () {
                      list[index].delete();
                    },
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
