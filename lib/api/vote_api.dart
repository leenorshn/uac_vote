import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:uac_vote2/api/appwrite.dart';
import 'package:uac_vote2/models/candidat.dart';
import 'package:uac_vote2/models/elector.dart';

class VoteApi {
  var client = AppwriteClient().getClientApp();

  Future updateVoteOnClient(String id) async {
    print("user_id: $id");
    var db = Databases(client);
    await db.updateDocument(
        databaseId: "66d1e1a800342cf76b75",
        collectionId: "66d1e27900021542dbbc",
        documentId: id,
        data: {"vote": true});
  }

  Future addVote(Candidat candidat, Elector elector) async {
    var db = Databases(client);
    var res = await db.getDocument(
      databaseId: "66d1e1a800342cf76b75",
      collectionId: "66d1e1bb0023afbc7721",
      documentId: candidat.id,
    );

    var dd = res.data;
    var candid = Candidat(
      id: res.$id,
      number: dd["numero"],
      name: dd["name"],
      image: dd["image"],
      type: dd["poste"],
      vote: dd["votes"],
    );

    print("**********");
    print(candid.id);
    print(candidat.id);
    print("**********");
    await db.updateDocument(
        databaseId: "66d1e1a800342cf76b75",
        collectionId: "66d1e1bb0023afbc7721",
        documentId: candidat.id,
        data: {"votes": candid.vote + 1});
  }
}
