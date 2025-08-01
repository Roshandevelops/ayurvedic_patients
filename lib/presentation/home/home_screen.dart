import 'dart:developer';
import 'package:ayurvedic_patients/infrastructure/auth_controller.dart';
import 'package:ayurvedic_patients/infrastructure/patient_controller.dart';
import 'package:ayurvedic_patients/presentation/register/register_patients.dart';
import 'package:ayurvedic_patients/presentation/widget/app_textformfield.dart';
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
  void fetchPatient()
  
  async{
  await Provider.of<PatientController>(context, listen: false) .fetchPatients();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientController>(
        builder: (context, patientConsumer, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.notifications),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Search bar
                  Row(
                    children: [
                      const Expanded(
                        child: AppTextFormField(
                          hint: "Search for treatements",
                          fillColor: Color(0xffFFFFFF),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff006837),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sort by row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Sort by :",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      DropdownButton<String>(
                        value: "Date",
                        items: const [
                          DropdownMenuItem(value: "Date", child: Text("Date")),
                          DropdownMenuItem(value: "Name", child: Text("Name")),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Booking list

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
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xffF1F1F1),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${index + 1}. ${patientConsumer.patients[index].name ?? "Unknown"}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      patientConsumer.patients[index].user ??
                                          "Unknown",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_month,
                                            size: 16, color: Colors.red),
                                        const SizedBox(width: 4),
                                        Text(
                                          DateFormat('dd/MM/yyyy').format(
                                              patientConsumer
                                                  .patients[index].createdAt!),
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.people_alt,
                                            size: 16, color: Colors.orange),
                                        const SizedBox(width: 4),
                                        Text(
                                            patientConsumer
                                                    .patients[index].user ??
                                                "Unknown",
                                            style:
                                                const TextStyle(fontSize: 13)),
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
                                        Icon(Icons.arrow_forward_ios, size: 16),
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
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return RegisterPatients();
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff006837),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Register Now',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      );
    });
  }
}
