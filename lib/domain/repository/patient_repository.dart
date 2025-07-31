import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ayurvedic_patients/core/api_constants.dart';
import 'package:ayurvedic_patients/domain/model/patient_model.dart';

class PatientRepository {
  Future<List<PatientModel>> fetchPatients(String token) async {
    try {
      final url = Uri.parse('$kBaseUrl/PatientList');

      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final patients = (jsonResponse['patient'] as List)
            .map(
              (e) => PatientModel.fromJson(e),
            )
            .toList();
        return patients;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
