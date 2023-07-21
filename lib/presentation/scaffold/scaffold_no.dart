import 'package:flutter/material.dart';

class ScaffoldNo extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Color? bgColor;
  const ScaffoldNo({
    required this.body,
    this.bgColor,
    this.bottomNavigationBar,
    this.drawer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor ?? Theme.of(context).canvasColor,
      //resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(elevation: 0),
      ),
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}
