// ignore_for_file: must_be_immutable

import 'package:doingly/config/services/tost_service.dart';
import 'package:doingly/data/models/user_model.dart';
import 'package:doingly/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../config/services/keyboard.dart';
import '../../config/tags.dart';
import '../routes/rout.dart';
import '../widgets/ReadyInput/login_arzan_input.dart';
import '../widgets/ReadyInput/ready_input_base.dart';
import '../widgets/btns_group.dart';
import '../widgets/my_pop_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      onWillPop: () async {
        // final themeP = ThemeP.of(context, listen: false);
        // if (themeP.isLoding) {
        //   themeP.changeIsLoading(false);
        // }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: buildContent()),
      ),
    );
  }

  bool isPressBefore = false;

  String? _nameValid() {
    if (isPressBefore) {
      if (RIBase.getText(Tags.rIUserName).length < 8) {
        //return "Enter min 7 char at Name";
        return "";
      }
    }
    return null;
  }

  Widget buildContent() {
    return Column(
      children: [
        const SizedBox(height: 20),
        CoolInputs(
          validator: (String? value) => _nameValid(),
          tag: Tags.rIUserName,
          iconD: Icons.supervised_user_circle_sharp,
          label: "Ulanyjy Ady",
          hidden: "Ulanyjy Ady",
        ),
        const SizedBox(height: 20),
        CoolInputs(
          validator: (String? value) => _nameValid(),
          tag: Tags.rIPass,
          iconD: Icons.vpn_key_outlined,
          label: "Açar sözi",
          hidden: "Açar sözi",
          type: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 20),
        CoolInputs(
          validator: (String? value) => _nameValid(),
          tag: Tags.rIEmail,
          iconD: Icons.email,
          label: "Elektron poçta",
          hidden: "Elektron poçta",
          type: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        buildSign(),
        const SizedBox(height: 30),
        SuccessBtn(
          iconD: Icons.forward,
          onTap: _register,
          text: "Let's Start",
        ),
      ],
    );
  }

  void _register() {
    Keyboard.close(context);
    MyPopUpp.popLoading(context);
    context
        .read<UserRepository>()
        .signUp(UserModel(
          name: RIBase.getText(Tags.rIUserName),
          pass: RIBase.getText(Tags.rIPass),
          email: RIBase.getText(Tags.rIEmail),
        ))
        .then((response) {
      MyPopUpp.popMessage(context, () {
        Navigator.popAndPushNamed(context, Rout.home);
      }, response.message, !response.status);
    });
    // UserP.of(context, listen: false)
    //     .signUp(UserEntity(
    //   name: RIBase.getText(Tags.rIUserName),
    //   pass: RIBase.getText(Tags.rIPass),
    //   email: RIBase.getText(Tags.rIEmail),
    // ))
    //     .then((response) {
    //   MyPopUpp.popMessage(context, () {
    //     Navigator.popAndPushNamed(context, Rout.home);
    //   }, response.message, !response.status);
    // });
  }

  Widget buildSign() {
    return TextButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, Rout.login);
        },
        child: const Text("Login"));
  }
}
