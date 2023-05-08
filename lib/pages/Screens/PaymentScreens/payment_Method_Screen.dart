import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Payment Methods"),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  InkWell paymentMethod() {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            Icon(
              Icons.dangerous,
            ),
            SizedBox(width: 10),
            Text("Google Pay"),
          ],
        ),
      ),
    );
  }
}
