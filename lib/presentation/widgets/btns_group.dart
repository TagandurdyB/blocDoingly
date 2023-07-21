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

// class LikeBtn extends StatefulWidget {
//   final Function? onTap;
//   final int likeCount;
//   final bool isLiked, isTongel, isWork;
//   final Color iconColor, textColor;
//   final Color? activeIconColor, passivIconColor;
//   final double iconSize, textSize, spacing;
//   final double? activeIconSize, passivIconSize;

//   const LikeBtn({
//     super.key,
//     this.onTap,
//     this.isWork = true,
//     this.likeCount = 0,
//     this.iconColor = Colors.red,
//     this.activeIconColor,
//     this.passivIconColor,
//     this.iconSize = 15,
//     this.activeIconSize,
//     this.passivIconSize,
//     this.textColor = Colors.white,
//     this.textSize = 15,
//     this.spacing = 4,
//     this.isLiked = false,
//     this.isTongel = false,
//   });

//   @override
//   State<LikeBtn> createState() => _LikeBtnState();
// }

// class _LikeBtnState extends State<LikeBtn> {
//   late bool isLiked;
//   late int likeCount;

//   @override
//   void initState() {
//     isLiked = widget.isLiked;
//     likeCount = widget.likeCount;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           if (widget.isWork) {
//             if (widget.isTongel) {
//               isLiked = !isLiked;
//               if (isLiked) {
//                 likeCount++;
//               } else {
//                 likeCount--;
//               }
//               SoundService.playLike;
//               //   if (widget.onTap != null) widget.onTap!(isLiked);
//             } else if (!isLiked) {
//               isLiked = true;
//               likeCount++;
//               SoundService.playLike;
//               //   if (widget.onTap != null) widget.onTap!(isLiked);
//             }
//           }
//           if (widget.onTap != null) widget.onTap!(isLiked);
//         });
//       },
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(isLiked ? Icons.favorite : Icons.favorite_border,
//               color: isLiked
//                   ? widget.activeIconColor ?? widget.iconColor
//                   : widget.passivIconColor ?? widget.iconColor,
//               size: isLiked
//                   ? widget.activeIconSize ?? widget.iconSize
//                   : widget.passivIconSize ?? widget.iconSize),
//           SizedBox(width: widget.spacing),
//           Text(
//             "$likeCount",
//             style: TextStyle(
//                 color: widget.textColor,
//                 // fontWeight: FontWeight.bold,
//                 fontSize: widget.textSize),
//           ),
//         ],
//       ),
//     );
//   }
// }
