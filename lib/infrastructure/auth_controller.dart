import 'dart:developer';

import 'package:ayurvedic_patients/domain/repository/auth_repository.dart';
import 'package:ayurvedic_patients/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();
  String? token;

  Future<void> login(
    String username,
    String password,
    BuildContext context,
  ) async {
    token = await authRepository.login(username, password);
    notifyListeners();
    if (token != null && context.mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed. Please check credentials."),
          ),
        );
      }
    }
    notifyListeners();
  }
}
