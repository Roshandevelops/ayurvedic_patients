import 'dart:convert';
import 'dart:developer';
import 'package:ayurvedic_patients/core/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<String?> login(String username, String password) async {
    try {
      final url = Uri.parse('$kBaseUrl/Login');

      var request = http.MultipartRequest('POST', url);
      request.fields['username'] = username;
      request.fields['password'] = password;

      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();

      log('Status Code: ${streamedResponse.statusCode}');
      log('Response Body: $responseString');

      if (streamedResponse.statusCode == 200) {
        final jsonResponse = jsonDecode(responseString);
        final token = jsonResponse['token'];
        final name = jsonResponse['user_details']['name'];

        log('Login Success');
        log('Token: $token');
        log('User: $name');

        return token;
      } else {
        return null;
      }
    } catch (e) {
      log('Login error: $e');
      return null;
    }
  }
}
