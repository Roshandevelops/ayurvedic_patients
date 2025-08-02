import 'dart:developer';
import 'package:ayurvedic_patients/core/api_constants.dart';
import 'package:http/http.dart' as http;

class UpdatePatientRepository {
  Future<bool> submitPatientData(
      {required Map<String, String> data, required String token}) async {
    try {
      final url = Uri.parse('$kBaseUrl/PatientUpdate');

      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(data);

      request.headers.addAll({"Authorization": "Bearer $token"});
      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();
      log('Status Code: ${streamedResponse.statusCode}');
      log('Response Body   vaasu: $responseString');
      if (streamedResponse.statusCode == 200) {
        log('Patient data submitted successfully.');
        return true;
      } else {
        log('Failed to submit patient data.');
        return false;
      }
    } catch (e) {
      log('Submission error: $e');
      return false;
    }
  }
}
