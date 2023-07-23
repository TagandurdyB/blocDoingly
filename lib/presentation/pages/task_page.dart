// ignore_for_file: must_be_immutable

import 'package:doingly/data/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../config/services/keyboard.dart';
// import '../../../domain/entities/list_entity.dart';
// import '../widgets/task_view.dart';
// import '/presentation/views/widgets/my_pop_widget.dart';
import 'package:flutter/material.dart';

// import '../../../config/routes/my_rout.dart';
// import '../../../config/vars/constants.dart';
// import '../../../domain/entities/task_entity.dart';
// import '../../providers/task_provider.dart';
// import '../../providers/user_provider.dart';
import '../../config/tags.dart';
import '../../data/models/list_model.dart';
import '../../logic/bloc/task_bloc.dart';
import '../routes/rout.dart';
import '../widgets/ReadyInput/ready_input_base.dart';
import '../widgets/my_pop_widget.dart';
import '../widgets/task_view.dart';

class TaskPage extends StatefulWidget {
  final ListModel? listObj;
  final int? listIndex;
  const TaskPage({this.listObj, this.listIndex, super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // late TaskP taskP, taskDo;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   taskDo = TaskP.of(context, listen: false);
    _fillTask();
    // });
  }

  Future<void> _fillTask() async {
    if (widget.listObj != null) {
      // taskDo.fillTaskByList(widget.listObj!.uuid);
      context.read<TaskBloc>().readTask(widget.listObj!.uuid);
    } else {
      context.read<TaskBloc>().readAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    // taskP = TaskP.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _fillTask(),
        color: Colors.orange,
        child: buildView(),
      ),
      floatingActionButton: widget.listObj != null
          ? FloatingActionButton(
              onPressed: _addList, child: const Icon(Icons.add))
          : null,
    );
  }

  Widget buildView() {
    final taskP = context.watch<TaskBloc>().state;
    if (widget.listObj != null) {
      return SingleChildScrollView(
        child: TaskView(
          objs: taskP.tasks,
          listObj: widget.listObj!,
          listIndex: widget.listIndex!,
          cardFunc: () {
            // taskDo.fillTaskByList(widget.listObj!.uuid);
          },
        ),
      );
    } else if (taskP.tasksAll != null) {
      return SingleChildScrollView(
        child: Column(
          children: List.generate(taskP.tasksAll!.length, (index) {
            final tasks = taskP.tasksAll![index];
            return TaskView(
              objs: tasks,
              listObj: tasks.first.list!,
              listIndex: index,
            );
          }),
          // children: taskP.tasksAll!
          //     .map((tasks) => TaskView(
          //           objs: tasks,
          //           listObj: tasks.first.list!,
          //           listIndex: ,
          //           cardFunc: () {
          //             // TODO
          //             // taskDo.fillAllTask();
          //           },
          //         ))
          //     .toList(),
        ),
      );
    } else {
      return const Center(
          child: CircularProgressIndicator(color: Colors.orange));
    }
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
      "Add Task",
      "Add",
      onTap: () {
        Keyboard.close(context);
        MyPopUpp.popLoading(context);
        context
            .read<TaskBloc>()
            .addTask(AddTask(
              task: TaskModel(
                name: RIBase.getText(Tags.rIPop),
                uuid: widget.listObj!.uuid,
                completed: false,
              ),
              // list: widget.listObj!,
              listIndex: widget.listIndex,
            ))
            .then((response) => MyPopUpp.popMessage(
                context, null, response.message, !response.status));
      },
      hidden: "New Task name",
      label: "New Task name",
      iconD: Icons.task_outlined,
    );
    // MyPopUpp.popInput(
    //   context,
    //   "Add Task",
    //   "Add",
    //   onTap: () {
    //     Keyboard.close(context);
    //     MyPopUpp.popLoading(context);
    //     taskDo
    //         .create(TaskEntity(
    //             name: RIBase.getText(Tags.rIPop),
    //             completed: false,
    //             uuid: widget.listObj!.uuid))
    //         .then((response) {
    //       taskDo.fillTaskByList(widget.listObj!.uuid);
    //       MyPopUpp.popMessage(
    //           context, null, response.message, !response.status);
    //     });
    //   },
    //   hidden: "New Task name",
    //   label: "New Task name",
    //   iconD: Icons.task_outlined,
    // );
  }
}
