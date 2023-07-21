// ignore_for_file: must_be_immutable

import '../../../config/services/my_size.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function? funcBack;
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? titleW;
  final TextStyle? style;
  late BuildContext context;
  final Color bgColor;
  final Color? color;
  CustomAppBar(
      {this.title = "Title",
      this.actions = const [],
      this.bgColor = Colors.white54,
      this.color,
      this.funcBack,
      this.leading,
      this.titleW,
      this.style,
      super.key});
  final double arentir = MySize.arentir;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      // color: Colors.white54,
      color: bgColor,
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: buildContent(),
    );
  }

  Widget buildContent() {
    return Row(
      children: [
        leading ?? BackButton(color: color),
        Expanded(
          child: titleW ??
              Text(
                title,
                style: style ?? TextStyle(fontSize: 22, color: color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        buildActions(),
      ],
    );
  }

  Widget buildActions() {
    return Row(
      children: actions!,
    );
  }
}
