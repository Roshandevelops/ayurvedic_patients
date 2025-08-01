import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:ayurvedic_patients/infrastructure/branch_controller.dart';
import 'package:ayurvedic_patients/infrastructure/patient_controller.dart';
import 'package:ayurvedic_patients/infrastructure/treatement_controller.dart';
import 'package:ayurvedic_patients/presentation/register/register_patients_screen.dart';
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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, 
          home: RegisterPatientsScreen()
          // SplashScreen(),
          ),
    );
  }
}
