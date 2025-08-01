import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:flutter/material.dart';

class SavedTreatments extends StatelessWidget {
  const SavedTreatments({super.key, required this.savedTreatments});

  final List<TreatmentModel> savedTreatments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: savedTreatments.map(
        (e) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffF0F0F0),
              border: Border.all(color: Color(0xffF0F0F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Treatment: ${e.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Male ",
                      style: TextStyle(color: Color(0xff006837)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        // color: Colors.green.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Color(0xff00000033).withOpacity(0.20)),
                      ),
                      child: Text(
                        '${e.male}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff006837)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Female ",
                      style: TextStyle(color: Color(0xff006837)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Color(0xff00000033).withOpacity(0.20)),
                      ),
                      child: Text(
                        '${e.female}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff006837)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
