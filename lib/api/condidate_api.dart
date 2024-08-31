import 'package:appwrite/appwrite.dart';
import 'package:uac_vote2/api/appwrite.dart';
import 'package:uac_vote2/models/candidat.dart';

class CandidatApi {
  var client = AppwriteClient().getClientApp();
  Future<List<Candidat>> getCandidats(String poste) async {
    var db = Databases(client);
    var response = await db.listDocuments(
        databaseId: "66d1e1a800342cf76b75",
        collectionId: "66d1e1bb0023afbc7721",
        queries: [
          Query.equal('poste', poste),
        ]);

    var docs = response.documents.map((t) {
      return Candidat(
          id: t.$id,
          number: t.data["numero"],
          image: t.data["image"],
          name: t.data["name"],
          type: t.data["poste"],
          vote: t.data["votes"]);
    }).toList();
    return docs;
  }
}
