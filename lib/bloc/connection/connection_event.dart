part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object> get props => [];
}

class OnConnectedEvent extends ConnectionEvent {}

class OnNotConnectedEvent extends ConnectionEvent {}
