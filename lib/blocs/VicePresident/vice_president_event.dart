part of 'vice_president_bloc.dart';

@immutable
abstract class VicePresidentEvent {}

class LoadVicePresidentEvent extends VicePresidentEvent {}

class UpdateVicePresidentEvent extends VicePresidentEvent {
  final List<Candidat> data;
  UpdateVicePresidentEvent(this.data);
}
