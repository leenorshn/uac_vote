part of 'president_bloc.dart';

@immutable
abstract class PresidentState {}

class PresidentInitial extends PresidentState {}

class PresidentLoadedSuccess extends PresidentState {
  final List<Candidat> candidats;
  PresidentLoadedSuccess(this.candidats);
}

class PresidentIsLoading extends PresidentState {}

class PresidentLoadedFailure extends PresidentState {}
