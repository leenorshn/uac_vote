import 'package:appwrite/appwrite.dart';
import 'package:uac_vote2/api/appwrite.dart';
import 'package:uac_vote2/models/program.dart';

class CalenderApi {
  var client = AppwriteClient().getClientApp();

  Stream<List<Program>> getProgram() async* {
    var db = Databases(client);
    var result = await db.listDocuments(
        databaseId: "66d1e1a800342cf76b75",
        collectionId: "66d1e885001c235156fe");
    var tt = result.documents.map((d) {
      return Program(d.data["libele"], d.data["date"]);
    }).toList();

    yield tt;
  }
}
