import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ai_assistant/helper/global.dart';
import 'package:http/http.dart' as http;


class APIs {
  static Future<void> getAnswer(String prompt) async {
    final uri = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey');

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    });

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final candidates = jsonResponse['candidates'];
        if (candidates != null && candidates.isNotEmpty) {
          final generatedContent = candidates[0]['content']['parts'][0]['text'];
          log('Generated Content: $generatedContent');
        } else {
          log('No candidates found in the response.');
        }
      } else {
        log('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
    }
  }
}


 // await APIs.getAnswer('Write a story about a magic backpack.');

