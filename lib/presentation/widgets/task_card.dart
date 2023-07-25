// ignore_for_file: must_be_immutable

import 'package:doingly/logic/bloc/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../config/services/my_size.dart';
import 'package:flutter/material.dart';

import '../../config/tags.dart';
import '../../data/models/task_model.dart';
import '../theme/shadows.dart';
import 'ReadyInput/ready_input_base.dart';
import 'my_pop_widget.dart';

class TaskCard extends StatelessWidget {
  final TaskModel obj;
  final int index;
  final int listIndex;
  final bool isReload;
  final Function? onTab;
  final Function? onFirst;
  final Function? onSecond;
  TaskCard({
    required this.obj,
    required this.index,
    required this.listIndex,
    this.isReload = false,
    this.onTab,
    this.onFirst,
    this.onSecond,
    super.key,
  });

  final double arentir = MySize.arentir;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab!();
        } else {
          context.read<TaskBloc>().updateTask(UpdateTask(
              task: obj.copyWith(completed: !obj.completed),
              // list: listObj,
              listIndex: listIndex,
              index: index));
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color:
                obj.completed ? Colors.purple : Theme.of(context).canvasColor,
            gradient: obj.completed
                ? LinearGradient(
                    colors: [Theme.of(context).canvasColor, Colors.green],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            boxShadow: ShadowsLight().list,
            borderRadius: BorderRadius.circular(8)),
        child: buildContent(),
      ),
    );
  }

//=========================
  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              obj.name,
              style: TextStyle(fontSize: arentir * 0.045),
            ),
          ),
          buildBtns(),
        ],
      ),
    );
  }

//Btns=======================
  Widget buildBtns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(obj.isEdit ? Icons.edit : Icons.add,
                color: obj.isEdit ? Colors.blue : Colors.green),
            const SizedBox(width: 10),
            Icon(obj.isConnect ? Icons.wifi : Icons.wifi_off_sharp,
                color: obj.isConnect ? Colors.green : Colors.orange),
          ],
        ),
        Row(mainAxisSize: MainAxisSize.min, children: [
          Visibility(
            visible: !isReload,
            child: Icon(
              obj.completed ? Icons.task_alt : Icons.check_box_outline_blank,
              color: Colors.green,
              size: arentir * 0.11,
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: !isReload,
            child: buildBtn(isReload ? Icons.replay_outlined : Icons.edit, () {
              if (onFirst != null) {
                onFirst!();
              } else {
                MyPopUpp.popInput(
                  context,
                  "Edit Task",
                  "Save",
                  startVal: obj.name,
                  hidden: "Task name",
                  label: "Task name",
                  onTap: () => _update(),
                  iconD: Icons.task_outlined,
                );
              }
            }, col: isReload ? Colors.green[800]! : Colors.blue),
          ),
          const SizedBox(width: 10),
          buildBtn(Icons.delete_forever, () {
            if (onSecond != null) {
              onSecond!();
            } else {
              MyPopUpp.popWarning(context, _delete);
            }
          }),
        ]),
      ],
    );
  }

  void _update() {
    MyPopUpp.popLoading(context);
    context
        .read<TaskBloc>()
        .updateTask(UpdateTask(
            task: obj.copyWith(name: RIBase.getText(Tags.rIPop)),
            index: index,
            // list: listObj,
            listIndex: listIndex))
        .then((response) => MyPopUpp.popMessage(
            context, () {}, response.message, !response.status));
  }

  void _delete() {
    MyPopUpp.popLoading(context);
    context
        .read<TaskBloc>()
        .deleteTask(DeleteTask(
          task: obj,
          listIndex: listIndex,
          index: index,
        ))
        .then((response) => MyPopUpp.popMessage(
            context, () {}, response.message, !response.status));
  }

  Widget buildBtn(IconData iconD, Function? func, {Color col = Colors.red}) {
    return InkWell(
      onTap: () {
        if (func != null) func();
      },
      child: Container(
          decoration:
              BoxDecoration(color: col, borderRadius: BorderRadius.circular(3)),
          height: arentir * 0.09,
          width: arentir * 0.09,
          child: Icon(
            iconD,
            size: arentir * 0.06,
            color: Colors.white,
          )),
    );
  }
}
