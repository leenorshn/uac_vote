import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uac_vote2/api/calender_api.dart';
import 'package:uac_vote2/models/program.dart';

part 'program_event.dart';
part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final CalenderApi api;
  StreamSubscription? subscription;
  ProgramBloc(this.api) : super(ProgramInitial()) {
    on<ProgramEvent>((event, emit) {
      if (event is LoadProgramEvent) {
        try {
          subscription = api.getProgram().listen((event) {
            return add(UpdateProgramEvent(event));
          });
        } catch (e) {
          emit(ProgramLoadedFailure());
        }
      }
      if (event is UpdateProgramEvent) {
        emit(ProgramLoadedSuccess(event.programs));
      }
    });
  }
}
