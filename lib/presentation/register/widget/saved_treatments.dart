import 'package:ayurvedic_patients/domain/model/treatement_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedTreatments extends StatelessWidget {
  const SavedTreatments({super.key, required this.savedTreatments});

  final List<TreatmentModel> savedTreatments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: savedTreatments.asMap().entries.map(
        (e) {
          final index = e.key;
          final treatment = e.value;
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffF0F0F0),
              border: Border.all(color: const Color(0xffF0F0F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Row with Close Icon
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${index + 1}. ${treatment.name}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        size: 30,
                        CupertinoIcons.clear_circled_solid,
                        color: const Color(0xffF21E1E).withOpacity(0.50),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                // Row with Male / Female & Edit Icon aligned to end
                Row(
                  children: [
                    // Gender counts section
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Male",
                            style: TextStyle(color: Color(0xff006837)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xff000000)
                                      .withOpacity(0.20)),
                            ),
                            child: Text(
                              '${treatment.male}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff006837),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            "Female",
                            style: TextStyle(color: Color(0xff006837)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: const Color(0xff000000)
                                      .withOpacity(0.20)),
                            ),
                            child: Text(
                              '${treatment.female}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff006837),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Edit Icon aligned to right under close icon
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.pencil_circle_fill,
                        size: 24,
                        color: const Color(0xff006837).withOpacity(0.7),
                      ),
                    )
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
