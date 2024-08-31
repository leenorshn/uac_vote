part of 'president_bloc.dart';

@immutable
abstract class PresidentEvent {}

class LoadPresidentEvent extends PresidentEvent {}

class UpdatePresidentEvent extends PresidentEvent {
  final List<Candidat> data;

  UpdatePresidentEvent(this.data);
}
