part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginElectorEvent extends LoginEvent {
  LoginElectorEvent();
}

class UpdateElectorEvent extends LoginEvent {
  final bool elector;
  UpdateElectorEvent(this.elector);
}

class LoadUserEvent extends LoginEvent {}

class UpdateUserEvent extends LoginEvent {
  final Elector elector;
  UpdateUserEvent(this.elector);
}
