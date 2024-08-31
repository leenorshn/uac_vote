part of 'program_bloc.dart';

@immutable
sealed class ProgramState {}

final class ProgramInitial extends ProgramState {}

class ProgramLoadedSuccess extends ProgramState {
  final List<Program> programs;
  ProgramLoadedSuccess(this.programs);
}

class ProgramLoadedFailure extends ProgramState {}
