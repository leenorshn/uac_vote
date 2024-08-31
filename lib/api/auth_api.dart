import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:uac_vote2/api/appwrite.dart';
import 'package:uac_vote2/models/elector.dart';

class AuthApi {
  var client = AppwriteClient().getClientApp();
  // var account = Account(client);

  Stream<Session?> getCurrentUser() async* {
    var account = Account(client);
    try {
      var session = await account.getSession(sessionId: "current");
      yield session;
    } catch (e) {
      yield null;
    }
  }

  Stream<Elector> getElectorUser() async* {
    var account = Account(client);
    var db = Databases(client);

    var user = await account.get();
    var rUser = await db.getDocument(
        databaseId: "66d1e1a800342cf76b75",
        collectionId: "66d1e27900021542dbbc",
        documentId: user.$id);

    var dd = rUser.data;
    Elector elector = Elector(
        id: rUser.$id,
        matricul: dd["matricule"],
        name: dd["name"],
        faculte: dd["faculte"],
        promo: dd["promotion"],
        vote: dd["vote"]);

    yield elector;
  }

  Future<Elector?> createAccount(String matricule, password) async {
    var account = Account(client);
    var db = Databases(client);
    // await account.create(
    //     userId: ID.unique(),
    //     email: "a$matricule@uac.com",
    //     password: password + "0000");
    var tt = await account.createEmailPasswordSession(
        email: "a$matricule@uac.com", password: password + "0000");
    tt.userId;
    var rUser = await db.getDocument(
        databaseId: "66d1e1a800342cf76b75",
        collectionId: "66d1e27900021542dbbc",
        documentId: tt.userId);

    var dd = rUser.data;
    Elector elector = Elector(
      id: rUser.$id,
      matricul: dd["matricule"],
      name: dd["name"],
      faculte: dd["faculte"],
      promo: dd["promotion"],
      vote: dd["vote"],
    );

    return elector;
  }
}
