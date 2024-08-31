import 'package:appwrite/appwrite.dart';

class AppwriteClient {
  Client getClientApp() {
    Client client = Client();
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d1dff30016396c687d')
        .setSelfSigned(status: true);

    return client;
  }
}
