import 'package:flutter/material.dart';

class PaymentRadioButtonWidget extends StatefulWidget {
  const PaymentRadioButtonWidget({super.key});

  @override
  State<PaymentRadioButtonWidget> createState() => _PaymentRadioButtonWidgetState();
}

class _PaymentRadioButtonWidgetState extends State<PaymentRadioButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return  Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Payment Option",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Cash',
                                  groupValue: "_selectedPayment",
                                  onChanged: (value) {
                                    setState(() {
                                      // _selectedPayment = value;
                                    });
                                  },
                                ),
                                const Text('Cash'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Card',
                                  groupValue: "_selectedPayment",
                                  onChanged: (value) {
                                    setState(() {
                                      // _selectedPayment = value;
                                    });
                                  },
                                ),
                                const Text('Card'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'UPI',
                                  groupValue: "_selectedPayment",
                                  onChanged: (value) {
                                    setState(() {
                                      // _selectedPayment = value;
                                    });
                                  },
                                ),
                                const Text('UPI'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
  }
}