import 'package:ayurvedic_patients/core/api_constants.dart';
import 'package:http/http.dart' as http;

class UpdatePatientRepository {
  Future<bool> submitPatientData(
      {required Map<String, String> data, required String token}) async {
    try {
      final url = Uri.parse(ApiConstants.patientUpdate);
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(data);
      request.headers.addAll({"Authorization": "Bearer $token"});
      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
