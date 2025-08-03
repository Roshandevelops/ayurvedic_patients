import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/infrastructure/patient_controller.dart';
import 'package:ayurvedic_patients/infrastructure/treatement_controller.dart';
import 'package:ayurvedic_patients/infrastructure/update_patient_controller.dart';
import 'package:ayurvedic_patients/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AuthController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return PatientController(
              authController:
                  Provider.of<AuthController>(context, listen: false),
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return BranchController(
              authController:
                  Provider.of<AuthController>(context, listen: false),
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return TreatementController(
              authController:
                  Provider.of<AuthController>(context, listen: false),
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return UpdatePatientController(
              authController:
                  Provider.of<AuthController>(context, listen: false),
            );
          },
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
