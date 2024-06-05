import 'dart:developer';

import 'package:ai_assistant/helper/global.dart';
import 'package:appwrite/appwrite.dart';

class AppWrite {
  static final _client = Client();
  static final _database = Databases(_client);

  static void init() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('6660b6810025dbd3ee87')
        .setSelfSigned(status: true);
    getApiKey();
  }

  static Future<String> getApiKey() async {
    try {
      final d = await _database.getDocument(
          databaseId: 'MyDatabase',
          collectionId: 'ApiKey',
          documentId: 'GeminiKey');
      apiKey = d.data['apiKey'];
      return d.data['apiKey'];
    } catch (e) {
      log('$e');
      return '';
    }
  }
}
