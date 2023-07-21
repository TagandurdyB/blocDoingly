import 'package:lottie/lottie.dart';

import '../../config/words.dart';
import '../routes/rout.dart';
import '../scaffold/scaffold_no.dart';
import '../widgets/btns_group.dart';
import '/config/services/my_size.dart';


import 'package:flutter/material.dart';

class PageDisconnect extends StatelessWidget {
  PageDisconnect({super.key});

  final double arentir = MySize.arentir;
  @override
  Widget build(BuildContext context) {
    final bool isFirst = ModalRoute.of(context)!.isFirst;
    return ScaffoldNo(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Words.disconnect,
            style: TextStyle(fontSize: arentir * 0.07),
            textAlign: TextAlign.center,
          ),
          Container(
            alignment: Alignment.center,
            child: Lottie.asset("assets/disconnect.json",
                width: double.infinity, height: arentir * 1, fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BorderBtn(
              color: const Color(0xff0EC243),
              text: Words.tryAgain,
              onTap: () {
                isFirst
                    ? Navigator.pushReplacementNamed(context, Rout.logo)
                    : Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    ));
  }
}
