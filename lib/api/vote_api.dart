import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:uac_vote2/api/appwrite.dart';
import 'package:uac_vote2/models/candidat.dart';

class VoteApi {
  var client = AppwriteClient().getClientApp();

  Future updateVoteOnClient() async {


    var db = Databases(client);
    var account=Account(client);

  var session=await  account.getSession(sessionId: "current");
 // if(session!=null) {
    await db.updateDocument(
        databaseId: "66d1e1a800342cf76b75",
        collectionId: "66d1e27900021542dbbc",
        documentId: session.userId,
        data: {"vote": true});
  //}
  }

  Future addVote(Candidat candidat) async {
    var db = Databases(client);

    //var account=Account(client);

   // var session=await  account.getSession(sessionId: "current");
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


    await db.updateDocument(
        databaseId: "66d1e1a800342cf76b75",
        collectionId: "66d1e1bb0023afbc7721",
        documentId: candidat.id,
        data: {"votes": candid.vote + 1});
  }
}
