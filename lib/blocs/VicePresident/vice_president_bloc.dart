import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uac_vote2/api/condidate_api.dart';

import '../../models/candidat.dart';

part 'vice_president_event.dart';
part 'vice_president_state.dart';

class VicePresidentBloc extends Bloc<VicePresidentEvent, VicePresidentState> {
  CandidatApi api;
  StreamSubscription? subscription;
  VicePresidentBloc(this.api) : super(VicePresidentInitial()) {
    on<VicePresidentEvent>((event, emit) {
      if (event is LoadVicePresidentEvent) {
        subscription =
            api.getCandidats("Vice_Presidentiel").asStream().listen((event) {
          return add(UpdateVicePresidentEvent(event));
        });
      }

      if (event is UpdateVicePresidentEvent) {
        emit(VicePresidentLoadedSuccess(event.data));
      }
    });
  }
}
