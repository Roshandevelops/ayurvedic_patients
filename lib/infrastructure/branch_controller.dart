import 'dart:developer';

import 'package:ayurvedic_patients/domain/model/branch_model.dart';
import 'package:ayurvedic_patients/domain/repository/branch_repository.dart';
import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:flutter/material.dart';

class BranchController extends ChangeNotifier {
  final AuthController authController;
  BranchController({required this.authController});
  List<BranchModel> branchList = [];
  bool isLoading = false;
  final BranchRepository branchRepository = BranchRepository();

  Future<void> getBranch() async {
    String token = authController.token ?? "";
    isLoading = true;
    notifyListeners();
    branchList = await branchRepository.getBranch(token);
    isLoading = false;
    notifyListeners();
  }
}
