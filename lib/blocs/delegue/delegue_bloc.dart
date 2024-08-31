import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uac_vote2/api/condidate_api.dart';
import 'package:uac_vote2/models/candidat.dart';

part 'delegue_event.dart';
part 'delegue_state.dart';

class DelegueBloc extends Bloc<DelegueEvent, DelegueState> {
  final CandidatApi api;
  StreamSubscription? subscription;
  DelegueBloc(this.api) : super(DelegueInitial()) {
    on<DelegueEvent>((event, emit) {
      if (event is LoadDelegueEvent) {
        emit(DelegueIsLoading());
        subscription = api.getCandidats("Deleguee").asStream().listen((event) {
          print(event[0].toString());
          add(UpdateDelegueEvent(event));
        });
      }

      if (event is UpdateDelegueEvent) {
        emit(DelegueLoadedSuccess(event.data));
      }
    });
  }
}
