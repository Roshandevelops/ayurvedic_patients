import 'dart:developer';
import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:ayurvedic_patients/domain/repository/treatement_repository.dart';
import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:flutter/material.dart';

class TreatementController extends ChangeNotifier {
  int maleCount = 0;
  int femaleCount = 0;

  final AuthController authController;
  TreatementController({required this.authController});
  List<TreatmentModel> treatmentList = [];
  bool isLoading = false;
  final TreatementRepository treatementRepository = TreatementRepository();

  Future<void> getAllTreatements() async {
    String token = authController.token ?? "";
    isLoading = true;
    notifyListeners();
    treatmentList = await treatementRepository.getAllTreatements(token);
    isLoading = false;
    notifyListeners();
  }

  void updateMaleCount(bool isIncrement) {
    if (isIncrement) {
      maleCount++;
    } else {
      if (maleCount > 0) maleCount--;
    }
    notifyListeners();
  }

  void updateFemaleCount(bool isIncrement) {
    if (isIncrement) {
      femaleCount++;
    } else {
      if (femaleCount > 0) femaleCount--;
    }
    notifyListeners();
  }

  void resetGenderCount() {
    maleCount = 0;
    femaleCount = 0;
    notifyListeners();
  }
}
