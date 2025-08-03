import 'package:ayurvedic_patients/infrastructure/patient_controller.dart';
import 'package:ayurvedic_patients/presentation/register/register_patients_screen.dart';
import 'package:ayurvedic_patients/presentation/widget/app_elevated_button.dart';
import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
import 'package:ayurvedic_patients/utils/k_color_constants.dart';
import 'package:ayurvedic_patients/utils/k_size_constants.dart';
import 'package:ayurvedic_patients/utils/k_text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchPatient();
    });
    super.initState();
  }

  void fetchPatient() async {
    await Provider.of<PatientController>(context, listen: false)
        .fetchPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientController>(
        builder: (context, patientConsumer, child) {
      return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.notifications),
            )
          ],
          backgroundColor: KColorConstants.kWhiteColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    /// Search bar
                    Row(
                      children: [
                        const Expanded(
                          child: AppTextFormField(
                            hint: KTextString.searchforTreatments,
                            fillColor: KColorConstants.kWhiteColor,
                            prefixIcon: Icon(CupertinoIcons.search,
                                color: KColorConstants.kGreyColor),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 50,
                          child: AppElevatedButton(
                            onPressed: () {},
                            buttonText: KTextString.search,
                            textStyle: const TextStyle(
                                color: KColorConstants.kWhiteColor),
                            backgroundColor:
                                KColorConstants.elevatedButtonGreenColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Sort by row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          KTextString.sortBy,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            height: 40,
                            width: 160,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(
                                30,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: KTextString.date,
                                borderRadius: BorderRadius.circular(10),
                                items: const [
                                  DropdownMenuItem(
                                    value: KTextString.date,
                                    child: Text(KTextString.date),
                                  ),
                                  DropdownMenuItem(
                                    value: KTextString.name,
                                    child: Text(KTextString.name),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    KSizeConstants.kHeight10,

                    /// Booking list
                    patientConsumer.isLoading
                        ? const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: patientConsumer.patients.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF1F1F1),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${index + 1}. ${patientConsumer.patients[index].name ?? "Unknown"}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      if (patientConsumer.patients[index]
                                                  .patientDetailsList !=
                                              null &&
                                          patientConsumer
                                              .patients[index]
                                              .patientDetailsList!
                                              .isNotEmpty) ...[
                                        Column(
                                          children: List.generate(
                                            patientConsumer.patients[index]
                                                .patientDetailsList!.length,
                                            (i) {
                                              final treatmentName =
                                                  patientConsumer
                                                          .patients[index]
                                                          .patientDetailsList![
                                                              i]
                                                          ?.treatmentName ??
                                                      "Unknown";
                                              return Text(
                                                treatmentName,
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            size: 16,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                patientConsumer.patients[index]
                                                    .createdAt!),
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                          const SizedBox(width: 16),
                                          const Icon(Icons.people_alt,
                                              size: 16, color: Colors.orange),
                                          const SizedBox(width: 4),
                                          Text(
                                              patientConsumer
                                                      .patients[index].user ??
                                                  "Unknown",
                                              style: const TextStyle(
                                                  fontSize: 13)),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "View Booking details",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Color(0xff006837),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AppElevatedButton(
                    backgroundColor: const Color(0xff006837),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const RegisterPatientsScreen();
                          },
                        ),
                      );
                    },
                    buttonText: "Register Now",
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      );
    });
  }
}
