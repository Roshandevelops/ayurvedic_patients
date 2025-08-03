import 'dart:convert';
import 'package:ayurvedic_patients/domain/model/branch_model.dart';
import 'package:http/http.dart' as http;
import 'package:ayurvedic_patients/core/api_constants.dart';

class BranchRepository {
  Future<List<BranchModel>> getBranch(String token) async {
    try {
      final url = Uri.parse(ApiConstants.branchList);
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final branchhes = (jsonResponse['branches'] as List)
            .map(
              (e) => BranchModel.fromJson(e),
            )
            .toList();
        return branchhes;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
