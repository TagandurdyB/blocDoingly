import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../config/tags.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState());

  ThemeMode get mode => state.isSystem
      ? ThemeMode.system
      : state.isLight
          ? ThemeMode.light
          : ThemeMode.dark;
//INIT=========================
void init(){
  checkSystem();
  checkLight();
}
//System============================================================


  void checkSystem() {
    bool? read = _read(Tags.themeSystem);
    if (read != null) {
      emit(state.copyWith(isSystem: read));
    } else {
      changeSystem(true);
    }
  }



  void changeSystem(bool val) {
    _save(Tags.themeSystem, val);
    emit(state.copyWith(isSystem: val));
  }

  void get tongleSystem {
    try {
      changeSystem(!state.isSystem);
    } catch (err) {
      throw ("Error on data Theme Provider tongleSystem:$err");
    }
  }

//Light=============================================================
  void checkLight() {
    bool? read = _read(Tags.themeLight);
    if (read != null) {
      emit(state.copyWith(isLight: read));
    } else {
      changeLight(true);
    }
  }

  void changeLight(bool val) {
    _save(Tags.themeLight, val);
    emit(state.copyWith(isLight: val));
  }

  void get tongleLight {
    try {
      changeLight(!state.isLight);
    } catch (err) {
      throw ("Error on data Theme Provider tongleMode:$err");
    }
  }

//Hive===========================================
  final myBase = Hive.box(Tags.hiveBase);

  void _save(String tag, bool val) => myBase.put(tag, val);

  bool? _read(String tag) => myBase.get(tag);
//!Hive===========================================

//PopUp==================================
  // bool _isLoading = false;
  // bool get isLoding => _isLoading;
  // void changeIsLoading(bool isLoad) {
  //   _isLoading = isLoad;
  // }

  // bool _warningOk = false;
  // bool get warningOk => _warningOk;
  // void changeWarning(bool isWar) {
  //   _warningOk = isWar;
  // }

//==

  static ThemeCubit of(context, {listen = true}) =>
      BlocProvider.of<ThemeCubit>(context, listen: listen);
}
