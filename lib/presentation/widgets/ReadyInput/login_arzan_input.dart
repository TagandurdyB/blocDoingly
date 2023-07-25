import 'package:flutter/material.dart';

import 'ready_input_base.dart';

class CoolInputs extends StatefulWidget {
  final TextInputType type;
  final String tag;
  final String hidden;
  final IconData iconD;
  final Widget? prefix;
  final String label;
  final String startVal;
  final Function? validator;
  final int? maxLength;
  final int maxLines;
  final bool readOnly;
  final EdgeInsetsGeometry? padding;
  final Function? onChanged;
  const CoolInputs({
    super.key,
    this.maxLength,
    this.maxLines = 1,
    this.validator,
    this.startVal = "",
    this.hidden = "",
    this.prefix,
    this.type = TextInputType.text,
    required this.tag,
    this.padding,
    this.iconD = Icons.edit,
    this.label = "",
    this.onChanged,
    this.readOnly = false,
  });

  @override
  State<CoolInputs> createState() => _CoolInputsState();
}

class _CoolInputsState extends State<CoolInputs> {
  bool isPassShow = false;
  final FocusNode focusNode = FocusNode();
  bool isFocus = false;
  bool isEmpty = true;
  Color enableBorderColor = Colors.grey;
  Color focusBorderColor = const Color(0xff008631);

  @override
  void initState() {
    super.initState();
    RIBase.changeDate(widget.tag, TextEditingController(text: widget.startVal));
    RIBase.getControl(widget.tag).addListener(() => setState(() {
          isEmpty = RIBase.isEmpety(widget.tag);
        }));
    focusNode.addListener(() {
      setState(() {
        // borderColor = focusNode.hasFocus ? Colors.orange : Colors.grey;
        isFocus = focusNode.hasFocus ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.label != "" && (isFocus || !isEmpty),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            //color: borderColor,
            width: double.infinity,
            // height: 20,
            child: Text(isFocus || !isEmpty ? widget.label : ""),
          ),
        ),
        buildFormInput(),
      ],
    );
  }

  Widget buildFormInput() {
    final themeInput = Theme.of(context).inputDecorationTheme;
    enableBorderColor = (isEmpty ? Colors.grey : themeInput.focusColor)!;
    return TextFormField(
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      controller: RIBase.getControl(widget.tag),
      focusNode: focusNode,
      obscureText: widget.type == TextInputType.visiblePassword && !isPassShow,
      obscuringCharacter: "*",
      style: TextStyle(
          // color: Colors.black,
          color: themeInput.hoverColor,
          fontSize: 16,
          letterSpacing: 1,
          decoration: TextDecoration.none,
          overflow: TextOverflow.visible,
          decorationStyle: TextDecorationStyle.dotted,
          decorationColor: Colors.white),
      // enableSuggestions: false,
      // decoration: const InputDecoration(
      //   border: InputBorder.none,
      // ),

      maxLength: widget.type == TextInputType.phone ? 8 : widget.maxLength,
      keyboardType: widget.type,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        counter: const Offstage(),
        // un show label
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.hidden,
        // floatingLabelAlignment: FloatingLabelAlignment.center,
        alignLabelWithHint: true,
        contentPadding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        labelStyle: const TextStyle(color: Colors.grey),
        errorStyle: const TextStyle(height: 0),
        prefixIcon: widget.prefix == null ? Icon(widget.iconD) : null,
        prefix: widget.prefix,
        prefixIconColor: enableBorderColor,
        suffixIcon: widget.type == TextInputType.visiblePassword
            ? GestureDetector(
                onTap: () => setState(() => isPassShow = !isPassShow),
                child: Icon(isPassShow
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined))
            : null,
        suffixIconColor: enableBorderColor,
        //  labelText: widget.label,
        // border: const OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.grey)),
        // remove under line
        border: InputBorder.none,
        // focusColor: Colors.orange,
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: focusBorderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: enableBorderColor)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red)),
      ),

      validator: (String? value) {
        if (widget.validator != null) return widget.validator!(value);
        return null;
      },
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
      },
    );
  }
}
