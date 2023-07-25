// ignore_for_file: must_be_immutable

import 'package:doingly/logic/bloc/list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/tags.dart';
import '../../data/models/list_model.dart';
import '../theme/colors.dart';
import '../theme/shadows.dart';

import '/config/services/my_size.dart';
import 'package:flutter/material.dart';

import 'ReadyInput/ready_input_base.dart';
import 'my_pop_widget.dart';

class ListCard extends StatelessWidget {
  final ListModel obj;
  final int index;
  final Function? onTab;
  final Function? onFirst;
  final Function? onSecond;
  final double bRadius;
  final bool isReload;
  ListCard(
      {required this.obj,
      required this.index,
      this.onTab,
      this.onFirst,
      this.onSecond,
      this.bRadius = 10,
      this.isReload = false,
      super.key});

  final double arentir = MySize.arentir;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return GestureDetector(
      onTap: () {
        if (onTab != null) onTab!();
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: arentir * 0.4,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            boxShadow: ShadowsLight().list,
            borderRadius: BorderRadius.circular(bRadius)),
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  obj.name,
                  style: TextStyle(fontSize: arentir * 0.05),
                ),
              ),
                     Row(
           children: [
             Icon(obj.isEdit ? Icons.edit : Icons.add,
                color: obj.isEdit ? Colors.blue : Colors.green),
                 const SizedBox(width: 10),
            Icon(obj.isConnect ? Icons.wifi : Icons.wifi_off_sharp,
                color: obj.isConnect ? Colors.green : Colors.orange),
               
            
           ],
         ),
            ],
          ),
        ),
        buildTaskCounter(),
        buildBtns(),
      ],
    );
  }

//Statistics==================================================
  Widget buildTaskCounter() {
    final isComplat = obj.taskCount == obj.completed;
    final isEmpty = obj.taskCount == 0;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildCounter("Tasks", obj.taskCount),
            buildCounter("Completed", obj.completed),
            buildCounter("Remainder", obj.taskCount - obj.completed),
          ]),
          Visibility(
              visible: isComplat || isEmpty,
              child: Text(isEmpty ? "Empty" : "Complated",
                  style: TextStyle(
                      color: isEmpty ? Colors.red : Colors.green,
                      fontSize: arentir * 0.05))),
          buildPercentage(
              obj.taskCount > 0 ? (obj.completed * 100 / obj.taskCount) : 0),
        ],
      ),
    );
  }

  Widget buildCounter(String text, int count) {
    return Text(
      "$text: $count",
      style: TextStyle(fontSize: arentir * 0.04),
    );
  }

  Widget buildPercentage(double persentage) {
    final width = arentir * 0.01;
    final Color color = ColorsLight().persent(persentage);
    final radius = arentir * 0.14;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: persentage),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, _) => Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: radius,
            width: radius,
            child: CircularProgressIndicator(
              value: value * 0.01,
              semanticsValue: "$value",
              color: color,
              // backgroundColor: bg,
              semanticsLabel: "$value",
              strokeWidth: width,
            ),
          ),
          Text("${value.floor()}%"),
        ],
      ),
    );
  }

//!Statistics==================================================
//Btns===================================================
  Widget buildBtns() {
    return Row(children: [
      buildBtn(isReload ? Icons.replay_outlined : Icons.edit,
          isReload ? "Reload" : "Edit", () {
        if (onFirst != null) {
          onFirst!();
        } else {
          MyPopUpp.popInput(
            context,
            "Edit List",
            "Save",
            startVal: obj.name,
            hidden: "List name",
            label: "List name",
            onTap: () => _update(),
          );
        }
      }, col: isReload ? Colors.green : Colors.blue),
      buildBtn(
          Icons.delete_forever,
          "Delet",
          () => MyPopUpp.popWarning(context, () {
                if (onSecond != null) {
                  onSecond!();
                } else {
                  _delete();
                }
              })),
    ]);
  }

  void _update() {
    MyPopUpp.popLoading(context);
    context
        .read<ListBloc>()
        .updateList(UpdateList(
          list: obj.copyWith(name: RIBase.getText(Tags.rIPop)),
          index: index,
        ))
        .then((response) => MyPopUpp.popMessage(
            context, () {}, response.message, !response.status));
  }

  void _delete() {
    MyPopUpp.popLoading(context);
    context
        .read<ListBloc>()
        .deleteList(DeleteList(list: obj, index: index))
        .then((response) => MyPopUpp.popMessage(
            context, () {}, response.message, !response.status));
  }

  Widget buildBtn(IconData iconD, String text, Function? func,
      {Color col = Colors.red}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (func != null) func();
        },
        child: Container(
            height: arentir * 0.08,
            color: col,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconD,
                  size: arentir * 0.06,
                  color: Colors.white,
                ),
                Text(
                  " $text",
                  style: TextStyle(fontSize: arentir * 0.05),
                ),
              ],
            )),
      ),
    );
  }
//!Btns==================================================
}
