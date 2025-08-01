import 'dart:developer';
import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:ayurvedic_patients/domain/repository/treatement_repository.dart';
import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:flutter/material.dart';

class TreatementController extends ChangeNotifier {
  final AuthController authController;
  TreatementController({required this.authController});
  List<TreatmentModel> treatmentList = [];
  bool isLoading = false;
  final TreatementRepository treatementRepository = TreatementRepository();

  Future<void> getAllTreatements() async {
    String token = authController.token ?? "";
    log("token is $token");
    isLoading = true;
    notifyListeners();
    treatmentList = await treatementRepository.getAllTreatements(token);
    isLoading = false;
    notifyListeners();
  }
}
