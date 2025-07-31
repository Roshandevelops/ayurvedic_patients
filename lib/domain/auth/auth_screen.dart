import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    authController = Provider.of<AuthController>(context, listen: false);

    super.initState();
  }

  late AuthController authController;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/login_image.png"),
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1 / 4,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login Or Register To Book\nYour Appointments",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AppTextFormField(
                      controller: emailController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Email',
                      hint: 'Enter your email',
                    ),
                    const SizedBox(
                      height: 25.02,
                    ),
                    AppTextFormField(
                      controller: passwordController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: 'Password',
                      hint: 'Enter password',
                    ),
                    const SizedBox(
                      height: 84.02,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: const Color(0xff006837)),
                        onPressed: () {
                          login(context);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  "By creating or logging into an account you are aggreing\nwith our ",
                              style: TextStyle(fontSize: 12)),
                          TextSpan(
                            text: "Terms and conditions ",
                            style: TextStyle(
                                color: Color(0xff0028FC), fontSize: 12),
                          ),
                          TextSpan(
                            text: "and ",
                            style: TextStyle(fontSize: 12),
                          ),
                          TextSpan(
                            text: "Privacy policy.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff0028FC),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    await authController.login(
      emailController.text,
      passwordController.text,
      context,
    );
  }
}
