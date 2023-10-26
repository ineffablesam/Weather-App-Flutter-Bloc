part of 'internet_bloc.dart';

abstract class InternetState {}

class InitialInternetState extends InternetState {}

class InternetConnected extends InternetState {
  String msg;
  InternetConnected({required this.msg});
}

class InternetDisconnected extends InternetState {
  String msg;
  InternetDisconnected({required this.msg});
}
