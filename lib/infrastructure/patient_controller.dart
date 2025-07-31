import 'package:ayurvedic_patients/domain/model/patient_model.dart';
import 'package:ayurvedic_patients/domain/repository/patient_repository.dart';
import 'package:flutter/material.dart';

class PatientController extends ChangeNotifier {
  List<PatientModel> patients = [];
  bool isLoading = false;

  final PatientRepository patientRepository=PatientRepository();

  

  Future<void> fetchPatients (String token) async {
    isLoading = true;
    notifyListeners();
    patients=await patientRepository.fetchPatients(token);
    isLoading=false;
    notifyListeners();

  }
}