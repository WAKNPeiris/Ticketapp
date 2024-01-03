import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: const Center(
          child: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Pay for your Ticket',
            style: TextStyle(
              color: Color.fromARGB(255, 101, 100, 100),
              fontSize: 25.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Price :',
            ),
          )
        ],
      )),
    );
  }
}
