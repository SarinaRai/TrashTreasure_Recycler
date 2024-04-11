import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final int totalAmount; //

  const PaymentPage({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Color.fromARGB(255, 2, 62, 33),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Amount: ${widget.totalAmount != null ? '\$${widget.totalAmount}' : 'N/A'}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Pay Now"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green), // Change color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
