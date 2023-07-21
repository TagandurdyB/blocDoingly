import 'package:hive/hive.dart';

import '../../../config/services/connection.dart';

import 'package:flutter/material.dart';

import '../../../config/services/my_size.dart';
import '../../config/tags.dart';
import '../../config/words.dart';
import '../routes/rout.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  int _selectedIndex = 0;
  bool? isConnect;

  @override
  void initState() {
    super.initState();
    _goHomeAsync();
    checkConnect();
  }

  void _goHomeAsync() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (isConnect != null) {
        if (_selectedIndex != 5) _goHome;
      } else {
        _goHomeAsync();
      }
    });
  }

  checkConnect() async {
    isConnect = await ConnectionService.isConnected();
  }

  void get _goHome async {
    final myBase = Hive.box(Tags.hiveBase);
    final bool? isLogin = myBase.get(Tags.hiveIsLogin);
    if (isLogin == true) {
      Navigator.pushReplacementNamed(context, Rout.home);
    } else if (isConnect!) {
      if (isLogin == false) {
        Navigator.pushReplacementNamed(context, Rout.login);
      } else {
        Navigator.pushReplacementNamed(context, Rout.register);
      }
    } else {
      Navigator.pushReplacementNamed(context, Rout.disconnect);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    MySize().changeSize(size.width, size.height);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[900]!, Colors.white],
            stops: const [0.1, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Center(child: buildLogo()),
            buildSifr(),
            Visibility(
              visible: _selectedIndex == 4,
              child: GestureDetector(
                onTap: () => _goHome,
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(Words.avtor,
                      style: TextStyle(color: Colors.orange)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSifr() {
    return Wrap(
        children: List.generate(
            4,
            (index) => GestureDetector(
                  onTap: () => _sifrFunc(index),
                  child: Container(
                    color: Colors.white24,
                    width: MySize.width * 0.5,
                    height: MySize.height * 0.5,
                  ),
                )));
  }

  void _sifrFunc(int index) {
    if (_selectedIndex != 4) {
      if (index == _selectedIndex) {
        _selectedIndex++;
        setState(() {});
      } else {
        {
          _selectedIndex = 0;
        }
      }
    }
  }

  Widget buildLogo() {
    final double arentir = MediaQuery.of(context).size.width;
    return Center(
        child: Container(
      width: arentir * 0.7,
      height: arentir * 0.3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(arentir * 0.06),
        border: Border.all(color: Colors.red, width: 3),
      ),
      child: Text(
        "DOINGLY",
        style: TextStyle(fontSize: arentir * 0.09),
      ),
    ));
  }
}
