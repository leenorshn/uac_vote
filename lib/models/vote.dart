import 'package:uac_vote2/models/candidat.dart';

class Vote {
  Candidat candidat;

  int vote;
  Vote(this.candidat, this.vote);
}

var votes = [];
