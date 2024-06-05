import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ai_assistant/helper/global.dart';
import 'package:http/http.dart' as http;

class APIs {
  static Future<String> getTextAnswer(String prompt) async {
    final uri = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey');

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
          return generatedContent;
        } else {
          log('No candidates found in the response.');
          throw Exception('No candidates found in the response.');
        }
      } else {
        log('Request failed with status: ${response.statusCode}');
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
      throw Exception('Error occurred: $e');
    }
  }

  static Future<String> getImageTextAnswer(String prompt,
      {List<String?>? base64Images}) async {
    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=$apiKey',
    );

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final List<Map<String, dynamic>> contents = [
      {"text": prompt}
    ];

    if (base64Images != null && base64Images.isNotEmpty) {
      for (var base64Image in base64Images) {
        contents.add({
          "inlineData": {
            "mimeType": "image/jpeg",
            "data": base64Image,
          }
        });
      }
    }

    final body = {
      "contents": [
        {"parts": contents}
      ],
    };

    try {
      final response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final candidates = jsonResponse['candidates'];
        if (candidates != null && candidates.isNotEmpty) {
          final generatedContent = candidates[0]['content']['parts'][0]['text'];
          log('Generated Content: $generatedContent');
          return generatedContent;
        } else {
          log('No candidates found in the response.');
          throw Exception('No candidates found in the response.');
        }
      } else {
        log('Request failed with status: ${response.statusCode}');
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
      throw Exception('Error occurred: $e');
    }
  }
}
