import 'dart:convert';
import 'package:ayurvedic_patients/core/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<String?> login(String username, String password) async {
    try {
      final url = Uri.parse(ApiConstants.login);

      var request = http.MultipartRequest('POST', url);
      request.fields['username'] = username;
      request.fields['password'] = password;

      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode == 200) {
        final jsonResponse = jsonDecode(responseString);
        final token = jsonResponse['token'];
 
        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
