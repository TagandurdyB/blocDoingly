



import '../../config/services/tost_service.dart';
import '../../config/tags.dart';
import '../../config/words.dart';
import '/config/services/my_size.dart';
import 'package:flutter/material.dart';

import 'ReadyInput/login_arzan_input.dart';

// import 'my_container.dart';

class ActionTeam {
  final Function? func;
  final String text;
  final bool canPop;
  final Widget? child;
  ActionTeam({
    this.func,
    this.child,
    this.text = "",
    this.canPop = true,
  });
}

class MyPopUpp {
  final double? width;
  final double? height;
  final double? borderRadius;
  Color? bgColor;
  final String? title;
  final bool centerTitle;
  final Color? titleCol;
  final Widget? content;
  final List<ActionTeam>? actions;
  final EdgeInsetsGeometry? padding;
  final bool barrierDismissible;
  MyPopUpp({
    this.content,
    this.centerTitle = true,
    this.width,
    this.height,
    this.title,
    this.borderRadius,
    this.bgColor,
    this.titleCol,
    this.actions,
    this.padding,
    this.barrierDismissible = false,
  });

  static void popLoading(BuildContext context) {
    final arentir = MySize.arentir;
    // ThemeP.of(context, listen: false).changeIsLoading(true);
    MyPopUpp(
        width: arentir * 0.6,
        height: arentir * 0.4,
        borderRadius: 10,
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                Words.loading,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: arentir * 0.04),
              ),
            ],
          ),
        )).pop(context);
  }

  static void popWarning(BuildContext context, Function func) {
    final arentir = MySize.arentir;
    MyPopUpp(
        barrierDismissible: true,
        width: arentir * 0.6,
        height: arentir * 0.4,
        title: "Pay attention!",
        titleCol: Colors.orange,
        borderRadius: 10,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                Words.delelteWarning,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: arentir * 0.04),
              ),
            ],
          ),
        ),
        actions: [
          ActionTeam(text: "Cancel"),
          ActionTeam(
              text: "Yes",
              func: () {
                Future.delayed(const Duration(milliseconds: 100))
                    .then((value) => func());
              }),
        ]).pop(context);
  }

  static void popInput(
    BuildContext context,
    String title,
    String btnText, {
    String startVal = "",
    String hidden = "",
    String label = "",
    IconData iconD = Icons.list,
    Function? onTap,
  }) {
    final arentir = MySize.arentir;
    // ThemeP.of(context, listen: false).changeIsLoading(true);
    MyPopUpp(
        barrierDismissible: true,
        width: arentir * 0.8,
        height: arentir * 0.5,
        borderRadius: 10,
        title: title,
        content: CoolInputs(
          startVal: startVal,
          hidden: hidden,
          label: label,
          iconD: iconD,
          tag: Tags.rIPop,
        ),
        actions: [
          ActionTeam(text: "Cancel"),
          ActionTeam(
              text: btnText,
              func: () {
                Future.delayed(const Duration(milliseconds: 100)).then((value) {
                  if (onTap != null) onTap();
                });
              }),
        ]).pop(context);
  }

  static void popEdit(BuildContext context) {
    final arentir = MySize.arentir;
    MyPopUpp(
        barrierDismissible: true,
        width: arentir * 0.6,
        height: arentir * 0.6,
        borderRadius: 10,
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.transparent,
            height: arentir * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildVerticalBtn(Icons.share_outlined, "Share",
                        const Color(0xff1079F3), null, () {
                      Navigator.pop(context);
                      TostService.soon;
                    }),
                    buildVerticalBtn(
                        Icons.link, "Link", const Color(0xff1079F3), null, () {
                      Navigator.pop(context);
                      TostService.soon;
                    }),
                    buildVerticalBtn(Icons.push_pin_outlined, "Pin",
                        const Color(0xff1079F3), null, () {
                      Navigator.pop(context);
                      TostService.soon;
                    }),
                  ],
                ),
                buildEditBtn(Icons.edit, "Posty uytgetmek",
                    const Color(0xff0EC243), null, () {
                  Navigator.pop(context);
                  TostService.soon;
                }),
                buildEditBtn(Icons.upload, "Ýokaryk galdyrmak",
                    const Color(0xff0EC243), null, () {
                  Navigator.pop(context);
                  TostService.soon;
                }),
                buildEditBtn(Icons.delete_forever, "Pozmak",
                    const Color(0xffFE0000), const Color(0xffFE0000), () {
                  Navigator.pop(context);
                  TostService.soon;
                }),
              ],
            ),
          ),
        )).pop(context);
  }

  static Widget buildVerticalBtn(IconData iconD, String text, Color iconColor,
      Color? textColor, Function func) {
    final double arentir = MySize.arentir;
    return Expanded(
      child: GestureDetector(
        onTap: () => func(),
        child: Column(
          children: [
            Icon(
              iconD,
              size: arentir * 0.07,
              color: iconColor,
            ),
            Text(
              text,
              style: TextStyle(fontSize: arentir * 0.04, color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildEditBtn(IconData iconD, String text, Color iconColor,
      Color? textColor, Function func) {
    final double arentir = MySize.arentir;
    return GestureDetector(
      onTap: () => func(),
      child: Row(
        children: [
          Expanded(
            child: Icon(
              iconD,
              size: arentir * 0.07,
              color: iconColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              text,
              style: TextStyle(fontSize: arentir * 0.04, color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  static void popMessage(
      BuildContext context, Function? onDo, String message, bool isError) {
    // // final themeP = ThemeP.of(context, listen: false);
    // if (themeP.isLoding) {
    //   themeP.changeIsLoading(false);
    //   Navigator.pop(context);
    // }
    final arentir = MySize.arentir;
    MyPopUpp(
        width: arentir * 0.6,
        height: arentir * 0.4,
        borderRadius: 10,
        content: Column(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outlined,
              color: isError ? Colors.red : Colors.green,
              size: arentir * 0.15,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: arentir * 0.04),
            ),
          ],
        )).pop(context);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
      // if (!isError) AcauntP.of(context, listen: false).changeScreen(0);
      if (!isError) {
        if (onDo != null) onDo();
      }
    });
  }

  late BuildContext context;
  void pop(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.dark;
    var mediaQuery = MediaQuery.of(context);
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
          bgColor = bgColor ??
              (isLight ? Theme.of(context).canvasColor : Colors.grey[800]);
          this.context = context;
          return AnimatedContainer(
            padding: mediaQuery.viewInsets,
            duration: const Duration(milliseconds: 300),
            child: GestureDetector(
              onTap: () {
                if (barrierDismissible) {
                  Navigator.pop(context);
                }
              },
              child: AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Center(child: buildPop())),
            ),
          );
        });
  }

  Widget buildPop() => Material(
        type: MaterialType.transparency,
        child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
            width: width,
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: title != null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title != null ? title! : "",
                      textAlign:
                          centerTitle ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                          fontSize: MySize.arentir * 0.05, color: titleCol),
                    ),
                  ),
                ),
                Padding(
                  padding: padding ?? const EdgeInsets.all(8),
                  child: content ?? const SizedBox(),
                ),
                PopBtns(actions: actions),
              ],
            )),
      );
}

// ignore: must_be_immutable
class PopBtns extends StatelessWidget {
  final List<ActionTeam>? actions;
  final bool isPopEnable;
  PopBtns({super.key, this.actions, this.isPopEnable = true});
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return buildBtns();
  }

  Widget buildBtns() => actions == null || actions!.isEmpty
      ? const SizedBox()
      : Row(
          children: actions!.map((e) => Expanded(child: buildBtn(e))).toList(),
        );

  Widget buildBtn(ActionTeam obj) {
    if (obj.child != null) {
      return GestureDetector(onTap: () => _tabFunc(obj), child: obj.child!);
    } else if (obj.text != "") {
      return TextButton(
          onPressed: () => _tabFunc(obj),
          child: Text(
            obj.text,
            style: const TextStyle(),
          ));
    } else {
      return const SizedBox();
    }
  }

  void _tabFunc(ActionTeam obj) {
    if (obj.func != null) {
      obj.func!();
    }
    if (isPopEnable && obj.canPop) {
      Navigator.pop(context);
    }
  }
}
