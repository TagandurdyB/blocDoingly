import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/counts.dart';

// import '/config/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  Connectivity conectivity;
  late StreamSubscription streamSubscription;
  InternetCubit({required this.conectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    streamSubscription = conectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi) {
        internetConnected(ConnectionType.wifi);
      } else if (event == ConnectivityResult.mobile) {
        internetConnected(ConnectionType.mobile);
      } else if (event == ConnectivityResult.none) {
        internetDisconnected();
      }
    });
  }

  void internetConnected(ConnectionType type) =>
      emit(InternetConnected(type: type));

  void internetDisconnected() => emit(InternetDisconnected());

  void migrate(){
    //TODO:
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
