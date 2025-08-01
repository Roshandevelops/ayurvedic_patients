import 'package:flutter/material.dart';

class GenderBox extends StatelessWidget {
  const GenderBox({
    super.key,
    required this.gender,
  });

  final String gender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        top: 16.5,
        bottom: 16.5,
        right: 77,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.53),
        border: Border.all(color: const Color(0xff000000).withOpacity(0.25)),
        color: const Color(0xffD9D9D9).withOpacity(0.25),
      ),
      child: Text(gender),
    );
  }
}
