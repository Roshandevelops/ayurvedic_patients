import 'package:ayurvedic_patients/infrastructure/patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientController>(
        builder: (context, patientConsumer, child) {
      return ListView.builder(
        itemCount: patientConsumer.patients.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffF1F1F1),
              border: Border.all(color: Colors.grey.shade300),
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
                  patientConsumer.patients[index].user ?? "Unknown",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                      DateFormat('dd/MM/yyyy')
                          .format(patientConsumer.patients[index].createdAt!),
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.people_alt,
                        size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      patientConsumer.patients[index].user ?? "Unknown",
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const Divider(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      );
    });
  }
}
