import 'dart:convert';
import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:http/http.dart' as http;
import 'package:ayurvedic_patients/core/api_constants.dart';

class TreatementRepository {
  Future<List<TreatmentModel>> getAllTreatements(String token) async {
    try {
      final url = Uri.parse('$kBaseUrl/TreatmentList');

      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final treatments = (jsonResponse['treatments'] as List)
            .map(
              (e) => TreatmentModel.fromJson(e),
            )
            .toList();
        return treatments;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
