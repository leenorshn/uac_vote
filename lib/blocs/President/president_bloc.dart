import "dart:async";

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uac_vote2/api/condidate_api.dart';

import '../../models/candidat.dart';

part 'president_event.dart';
part 'president_state.dart';

class PresidentBloc extends Bloc<PresidentEvent, PresidentState> {
  CandidatApi api;
  StreamSubscription? subscription;
  PresidentBloc(this.api) : super(PresidentInitial()) {
    on<PresidentEvent>((event, emit) {
      if (event is LoadPresidentEvent) {
        emit(PresidentIsLoading());
        subscription =
            api.getCandidats("Presidentiel").asStream().listen((event) {
          /// print(event[0].toString());
          add(UpdatePresidentEvent(event));
        });
      }

      if (event is UpdatePresidentEvent) {
        emit(PresidentLoadedSuccess(event.data));
      }
    });
  }
}
