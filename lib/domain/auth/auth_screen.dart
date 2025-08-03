import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:ayurvedic_patients/presentation/widget/app_elevated_button.dart';
import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
import 'package:ayurvedic_patients/utils/k_color_constants.dart';
import 'package:ayurvedic_patients/utils/k_size_constants.dart';
import 'package:ayurvedic_patients/utils/k_text_strings.dart';
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
                    image: AssetImage(KTextString.loginImage),
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1 / 4,
              ),
              KSizeConstants.kHeight20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      KTextString.loginOrRegisterTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    KSizeConstants.kHeight30,
                    AppTextFormField(
                      controller: emailController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: KTextString.email,
                      hint: KTextString.enterYourEmail,
                    ),
                    const SizedBox(
                      height: 25.02,
                    ),
                    AppTextFormField(
                      controller: passwordController,
                      fillColor: const Color(0xFFD9D9D9).withOpacity(0.25),
                      title: KTextString.password,
                      hint: KTextString.enterPassword,
                    ),
                    const SizedBox(
                      height: 84.02,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AppElevatedButton(
                        backgroundColor:
                            KColorConstants.elevatedButtonGreenColor,
                        onPressed: () {
                          login(context);
                        },
                        buttonText: KTextString.login,
                        textStyle: const TextStyle(
                            color: KColorConstants.kWhiteColor, fontSize: 16),
                      ),
                    ),
                    KSizeConstants.kHeight60,
                    const Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: KTextString.byCreating,
                            style: TextStyle(fontSize: 12),
                          ),
                          TextSpan(
                            text: KTextString.termsAndCondition,
                            style: TextStyle(
                              color: KColorConstants.linkColor,
                            ),
                          ),
                          TextSpan(
                            text: KTextString.and,
                            style: TextStyle(fontSize: 12),
                          ),
                          TextSpan(
                            text: KTextString.privacyPolicy,
                            style: TextStyle(
                              fontSize: 12,
                              color: KColorConstants.linkColor,
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
