import '../../../../config/services/my_size.dart';
import '/presentation/widgets/ReadyInput/ready_input_base.dart';
import 'package:flutter/material.dart';

class VerificationInput extends StatelessWidget {
  final String tag;
  final int count;
  final Function? validator;
  const VerificationInput(
      {this.validator, this.count = 6, required this.tag, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
          (index) => _BuildInput(
              validator: validator,
              tag: tag,
              count: count,
              first: index == 0 ? true : false,
              last: index == count - 1 ? true : false,
              index: index),
        ));
  }
}

class _BuildInput extends StatefulWidget {
  final bool first;
  final bool last;
  final int count;
  final int index;
  final Function? validator;
  final String tag;
  const _BuildInput({
    this.validator,
    required this.first,
    required this.last,
    required this.index,
    required this.count,
    required this.tag,
  });

  @override
  State<_BuildInput> createState() => __BuildInputState();
}

class __BuildInputState extends State<_BuildInput> {
  final Color focusBorderColor = const Color(0xff008631);
  final Color disableBorderColor = Colors.grey;
  TextEditingController controller = TextEditingController();
  bool isEmpty = true;
  bool isFocus = false;

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.index == widget.count - 1) {
      String code = "";
      for (int i = 0; i < widget.count; i++) {
        code += " ";
      }
      RIBase.changeDate(widget.tag, TextEditingController(text: code));
    }
    focusNode.addListener(() {
      setState(() {
        isFocus = focusNode.hasFocus ? true : false;
      });
    });
  }

  void _funcChange(String value) {
    setState(() {
      if (value.isEmpty) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
    });

    if (value.length == 1 && widget.last == false) {
      FocusScope.of(context).nextFocus();
    }
    if (value.isEmpty && widget.first == false) {
      FocusScope.of(context).previousFocus();
    }

    String code = RIBase.getText(widget.tag);
    final characters = code.characters.toList();
    characters[widget.index] = controller.text == "" ? " " : controller.text;
    code = characters.join('');
    debugPrint(
        "Verification code:= $code   Verification  control:=${controller.text}");
    RIBase.changeDate(widget.tag, TextEditingController(text: code));
  }

  @override
  Widget build(BuildContext context) {
    final double arentir = MySize.arentir;
        final themeInput = Theme.of(context).inputDecorationTheme;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          width: arentir * 0.12,
          height: arentir * 0.14,
          //color: Colors.red,
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1,
            child: TextFormField(
              validator: (String? val) {
                if (widget.validator != null) {
                  return widget.validator!(val);
                }
                return null;
              },
              focusNode: focusNode,
              controller: controller,
              autofocus: true,
              onChanged: (value) => _funcChange(value),
              showCursor: false,
              // readOnly: false,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: arentir * 0.07, color:themeInput.hoverColor),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                counter: const Offstage(),
                counterStyle: const TextStyle(height: 0),
                errorStyle: const TextStyle(height: 0),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(arentir * 0.015)),
                    borderSide: BorderSide(color: focusBorderColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(arentir * 0.015)),
                    borderSide: BorderSide(
                        color:
                            isEmpty ? disableBorderColor : themeInput.focusColor!)),
                errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(arentir * 0.015)),
                    borderSide: const BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(arentir * 0.015)),
                    borderSide: BorderSide(color: focusBorderColor)),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isEmpty && !isFocus,
          child: Container(
            padding: EdgeInsets.all(arentir * 0.01),
            alignment: Alignment.bottomCenter,
            width: arentir * 0.12,
            height: arentir * 0.12,
            //color: Colors.blue,
            child: Container(
              width: arentir * 0.06,
              height: arentir * 0.005,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
