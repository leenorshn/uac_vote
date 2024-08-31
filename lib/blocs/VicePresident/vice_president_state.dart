part of 'vice_president_bloc.dart';

@immutable
abstract class VicePresidentState {}

class VicePresidentInitial extends VicePresidentState {}

class VicePresidentLoadedSuccess extends VicePresidentState {
  final List<Candidat> data;

  VicePresidentLoadedSuccess(this.data);
}
