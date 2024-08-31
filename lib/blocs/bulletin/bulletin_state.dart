part of 'bulletin_bloc.dart';

@immutable
abstract class BulletinState {}

class BulletinInitial extends BulletinState {}

class BulletinLoadedSuccess extends BulletinState {
  final List<Candidat> data;
  BulletinLoadedSuccess(this.data);
}
