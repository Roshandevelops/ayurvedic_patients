import 'package:ayurvedic_patients/domain/model/patient_model.dart';
import 'package:ayurvedic_patients/domain/repository/patient_repository.dart';
import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:flutter/material.dart';

class PatientController extends ChangeNotifier {
  
    final AuthController authController;
    PatientController({required this.authController});
  List<PatientModel> patients = [];
  bool isLoading = false;

  final PatientRepository patientRepository=PatientRepository();

  

  Future<void> fetchPatients () async {
    String token = authController.token??"";
    isLoading = true;
    notifyListeners();
    patients=await patientRepository.fetchPatients(token);
    isLoading=false;
    notifyListeners();

  }
}