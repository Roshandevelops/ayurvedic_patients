import 'package:ayurvedic_patients/domain/repository/update_patient_repository.dart';
import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:flutter/material.dart';

class UpdatePatientController extends ChangeNotifier {
  final AuthController authController;
  UpdatePatientController({
    required this.authController,
  });

  final UpdatePatientRepository updatePatientRepository =
      UpdatePatientRepository();

  Future<void> submitPatientData({
    required Map<String, String> data,
  }) async {
    await updatePatientRepository.submitPatientData(
        token: authController.token ?? "", data: data);
  }
}
