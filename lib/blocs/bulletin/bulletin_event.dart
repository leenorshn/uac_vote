part of 'bulletin_bloc.dart';

@immutable
abstract class BulletinEvent {}

class LoadBulletinEvent extends BulletinEvent {}

class UpdateBulletinEvent extends BulletinEvent {
  final List<Candidat> bulletin;
  UpdateBulletinEvent(this.bulletin);
}

class AddPresidentInBulletinEvent extends BulletinEvent {
  final Candidat candidat;
  AddPresidentInBulletinEvent(this.candidat);
}

class AddVicePresidentInBulletinEvent extends BulletinEvent {
  final Candidat candidat;
  AddVicePresidentInBulletinEvent(this.candidat);
}

class AddDelegueInBulletinEvent extends BulletinEvent {
  final Candidat candidat;
  AddDelegueInBulletinEvent(this.candidat);
}

class VideBulletinEvent extends BulletinEvent {}
