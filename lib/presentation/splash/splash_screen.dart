import 'package:ayurvedic_patients/domain/auth/auth_screen.dart';
import 'package:ayurvedic_patients/utils/text_strings.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          KTextString.splashImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void goToLogin(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (context.mounted) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const AuthScreen();
          },
        ),
      );
    }
  }
}
