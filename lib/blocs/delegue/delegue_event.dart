part of 'delegue_bloc.dart';

@immutable
sealed class DelegueEvent {}

class LoadDelegueEvent extends DelegueEvent {}

class UpdateDelegueEvent extends DelegueEvent {
  final List<Candidat> data;

  UpdateDelegueEvent(this.data);
}
