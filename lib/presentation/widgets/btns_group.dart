import 'package:flutter/material.dart';

// import '../../../config/services/soud_service.dart';

class SuccessBtn extends StatelessWidget {
  final String text;
  final Color color;
  final double bRadius;
  final Function? onTap;
  final IconData? iconD;
  const SuccessBtn(
      {this.text = "Jaň et",
      this.color = const Color(0xff0EC243),
      this.bRadius = 10,
      this.onTap,
      this.iconD,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(bRadius)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconD ?? Icons.phone, color: Colors.white),
            const SizedBox(width: 10),
            Text(text,
                style: const TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class BorderBtn extends StatelessWidget {
  final String text;
  final Color color;
  final double bRadius;
  final Function? onTap;
  const BorderBtn(
      {this.text = "Şikaýat et",
      this.color = const Color(0xffE50027),
      this.bRadius = 10,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(bRadius)),
        child: Text(text, style: TextStyle(fontSize: 18, color: color)),
      ),
    );
  }
}

class DangerBtn extends StatelessWidget {
  const DangerBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
