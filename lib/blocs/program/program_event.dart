part of 'program_bloc.dart';

@immutable
sealed class ProgramEvent {}

class LoadProgramEvent extends ProgramEvent {}

class UpdateProgramEvent extends ProgramEvent {
  final List<Program> programs;
  UpdateProgramEvent(this.programs);
}
