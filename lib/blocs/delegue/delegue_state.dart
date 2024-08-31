part of 'delegue_bloc.dart';

@immutable
sealed class DelegueState {}

final class DelegueInitial extends DelegueState {}

class DelegueIsLoading extends DelegueState {}

class DelegueLoadedSuccess extends DelegueState {
  final List<Candidat> candidats;
  DelegueLoadedSuccess(this.candidats);
}
