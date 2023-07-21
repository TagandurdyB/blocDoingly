import '../../../../config/services/keyboard.dart';
import 'package:flutter/material.dart';

import 'ready_input_base.dart';

class SearchInput extends StatefulWidget {
  final String tag;
  final String startVal;
  final String hidden;
  final Function? onTap;
  final Function? onEditingComplete;
  final FocusNode? focus;
  final Widget? prefix;
  final IconData iconD;
  const SearchInput(
      {required this.tag,
      this.prefix,
      this.iconD = Icons.search,
      this.startVal = "",
      this.hidden = "",
      this.onTap,
      this.onEditingComplete,
      this.focus,
      super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  void initState() {
    super.initState();
    RIBase.changeDate(widget.tag, TextEditingController(text: widget.startVal));
    // RIBase.getControl(widget.tag).addListener(() => setState(() {
    //       isEmpty = RIBase.isEmpety(widget.tag);
    //     }));
    // focusNode.addListener(() {
    //   setState(() {
    //     // borderColor = focusNode.hasFocus ? Colors.orange : Colors.grey;
    //     isFocus = focusNode.hasFocus ? true : false;
    //   });
    // });
  }

  final Color focusBorderColor = const Color(0xff00C52B);
  final Color enableBorderColor = const Color(0xffC4C4C4);
  final double borderRad = 7;
  final double enableWidth = 1;
  final double focusWidth = 2;

  @override
  Widget build(BuildContext context) {
    // final themeInput = Theme.of(context).inputDecorationTheme;
    return TextFormField(
      controller: RIBase.getControl(widget.tag),
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      onEditingComplete: () {
        Keyboard.close(context);
        if (widget.onEditingComplete != null) widget.onEditingComplete!();
      },
      focusNode: widget.focus,
      style: const TextStyle(
          // color: Colors.black,
          // color: themeInput.hoverColor,
          color: Color(0xff00C52B),
          fontSize: 16,
          letterSpacing: 1,
          decoration: TextDecoration.none,
          overflow: TextOverflow.visible,
          decorationStyle: TextDecorationStyle.dotted,
          decorationColor: Colors.white),
      // textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        // counter: const Offstage(),
        // un show label
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.hidden,
        hintStyle: const TextStyle(color: Color(0xffC4C4C4)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        suffixIcon: widget.prefix ?? Icon(widget.iconD),
        suffixIconColor: enableBorderColor,

        // suffixIcon: widget.type == TextInputType.visiblePassword
        //     ? GestureDetector(
        //         onTap: () => setState(() => isPassShow = !isPassShow),
        //         child: Icon(isPassShow
        //             ? Icons.visibility_outlined
        //             : Icons.visibility_off_outlined))
        //     : null,
        // suffixIconColor: enableBorderColor,

        //  labelText: widget.label,
        // border: const OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.grey)),
        // remove under line
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRad)),
            borderSide: BorderSide(color: focusBorderColor, width: focusWidth)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRad)),
            borderSide:
                BorderSide(color: enableBorderColor, width: enableWidth)),
      ),
    );
  }
}
