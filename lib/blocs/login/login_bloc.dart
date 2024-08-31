import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uac_vote2/api/auth_api.dart';
import 'package:uac_vote2/models/elector.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthApi api;
  StreamSubscription? subscription;
  LoginBloc(this.api) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      if (event is LoginElectorEvent) {
        try {
          subscription = api.getCurrentUser().listen((event) {
            if (event != null && event.current) {
              //print(event);
              return add(UpdateElectorEvent(true));
            } else {
              return add(UpdateElectorEvent(false));
            }
          });
        } catch (e) {
          emit(LoginFailure());
        }
      }
      if (event is LoadUserEvent) {
        subscription = api.getElectorUser().listen((d) {
          return add(UpdateUserEvent(d));
        });
      }

      if (event is UpdateUserEvent) {
        emit(UserLoaded(event.elector));
      }

      if (event is UpdateElectorEvent) {
        emit(LoginSuccess(event.elector));
      }
    });
  }
}
