import 'package:http/http.dart' as http;
import 'dart:convert'; // For json encoding/decoding

class BGraph {
  static const apiKey = 'da2-66gtz3kyc5cdlnzhq7o7oai6nq';
  static const String url =
      'https://5cw5bnrrtjbshl3clvtn3brjt4.appsync-api.us-east-2.amazonaws.com/graphql';
  static Future<http.Response> listEvents(String query,
      {Map<String, dynamic>? variables}) async {
    final headers = {'Content-Type': 'application/json', 'x-api-key': apiKey};
    final requestBody = json.encode({'query': query});
    try {
      return await http.post(
        Uri.parse(url),
        headers: headers,
        body: requestBody,
      );
    } catch (e) {
      print('An error occurred: $e');
    }
    return Future(() => http.Response("REQUEST FAILED", 500));
  }

  static Future<http.Response> createEvent(String query,
      {Map<String, dynamic>? variables}) async {
    final headers = {'Content-Type': 'application/json', 'x-api-key': apiKey};
    final requestBody = json.encode({
      'query': query,
      'variables': variables,
    });
    try {
      return await http.post(
        Uri.parse(url),
        headers: headers,
        body: requestBody,
      );
    } catch (e) {
      print('An error occurred: $e');
    }
    return Future(() => http.Response("REQUEST FAILED", 500));
  }
}
