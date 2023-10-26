part of 'internet_bloc.dart';

abstract class InternetEvent {}

class OnConnected extends InternetEvent {}

class OnDisconnected extends InternetEvent {}
