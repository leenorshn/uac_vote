part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final bool elector;
  LoginSuccess(this.elector);
}

class LoginFailure extends LoginState {}

class UserLoaded extends LoginState {
  final Elector user;
  UserLoaded(this.user);
}

class UserIsLoading extends LoginState {}
