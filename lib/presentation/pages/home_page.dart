// ignore_for_file: must_be_immutable

import 'package:doingly/logic/bloc/list_bloc.dart';
import 'package:doingly/logic/bloc/task_bloc.dart';
import 'package:doingly/logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../../config/hive_boxes.dart';
import '../../config/services/keyboard.dart';
import '../../config/tags.dart';
import '../routes/rout.dart';
import '../scaffold/custom_drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/ReadyInput/ready_input_base.dart';
import '../widgets/list_card.dart';
import '../widgets/my_pop_widget.dart';
import 'task_page.dart';

// import '../widgets/list_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late ListP listP, listDo;

  @override
  void initState() {
    super.initState();
    if (Boxes.isMigrate == true) {
      final internet = context.read<InternetCubit>();
      if (internet.state is InternetConnected) {
        internet.migrate();
      }
    }
    context.read<ListBloc>().readList();
  }

  @override
  Widget build(BuildContext context) {
    // listP = ListP.of(context);
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (Boxes.isMigrate == true) {
          if (state is InternetConnected) {
            // MyPopUpp.popLoading(context);
            final hiveDeleteList = Boxes.hiveListsDelete().values.toList();
            for (int i = 0; i < hiveDeleteList.length; i++) {
              if (hiveDeleteList[i].isConnect) {
                context
                    .read<ListBloc>()
                    .deleteList(DeleteList(list: hiveDeleteList[i]));
              }
            }
            //========
            final hiveDeleteTask = Boxes.hiveTasksDelete().values.toList();
            for (int i = 0; i < hiveDeleteTask.length; i++) {
              for (int j = 0; i < hiveDeleteTask[i].length; j++) {
                if (hiveDeleteTask[i][j].isConnect) {
                  context.read<TaskBloc>().deleteTask(
                      DeleteTask(task: hiveDeleteTask[i][j], listIndex: i));
                }
              }
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lists"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))
          ],
        ),
        drawer: CustomDrawer(),
        body: buildContent(),
        floatingActionButton: FloatingActionButton(
            onPressed: _addList, child: const Icon(Icons.add)),
      ),
    );
  }

  void _logOut() {
    final myBase = Hive.box(Tags.hiveBase);
    myBase.put(Tags.hiveToken, null);
    myBase.put(Tags.hiveIsLogin, false);
    Navigator.pushNamedAndRemoveUntil(context, Rout.login, (route) => false);
  }

  void _addList() {
    MyPopUpp.popInput(
      context,
      "Add List",
      "Add",
      onTap: () {
        Keyboard.close(context);
        MyPopUpp.popLoading(context);
        context
            .read<ListBloc>()
            .addList(AddList(name: RIBase.getText(Tags.rIPop)))
            .then((response) => MyPopUpp.popMessage(
                context, null, response.message, !response.status));
      },
      hidden: "New List name",
      label: "New List name",
    );
  }

  Widget buildContent() {
    return BlocBuilder<ListBloc, ListState>(builder: (context, state) {
      if (state is ListUpdate) {
        final lists = state.lists;
        if (lists.isNotEmpty) {
          return RefreshIndicator(
            color: Colors.orange,
            onRefresh: _refresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: lists.length + 1,
              itemBuilder: (context, index) {
                if (index < lists.length) {
                  return ListCard(
                    obj: lists[index],
                    index: index,
                    onTab: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskPage(
                                    listObj: lists[index],
                                    listIndex: index,
                                  )));
                    },
                  );
                } else {
                  return const SizedBox(height: 80);
                }
              },
            ),
          );
        } else {
          return const Center(child: Text("You don't have any list!"));
        }
      } else {
        return const Center(
            child: CircularProgressIndicator(color: Colors.orange));
      }
    });
  }

  Future<void> _refresh() {
    return context.read<ListBloc>().readList().then((value) => true);
  }
}
