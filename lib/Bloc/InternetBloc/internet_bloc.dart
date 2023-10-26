import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _internetStreamSubscription;

  InternetBloc() : super(InitialInternetState()) {
    on<OnConnected>((event, emit) {
      emit(InternetConnected(msg: "Connected"));
    });
    on<OnDisconnected>((event, emit) {
      emit(InternetDisconnected(msg: "Disconnected"));
    });
    _internetStreamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(OnConnected());
      } else {
        add(OnDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    _internetStreamSubscription?.cancel();
    return super.close();
  }
}
