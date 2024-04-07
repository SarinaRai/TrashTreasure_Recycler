import 'package:flutter/material.dart';
import 'package:trashtreasure_recycler/pages/payment.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> quantities = [0, 0, 0]; // Quantity for each product
  List<int> prices = [10, 10, 10]; // Price for each product
  int total = 0; // Total price for all items in the cart

  void increaseQuantity(int index) {
    setState(() {
      quantities[index]++;
      updateTotal();
    });
  }

  void decreaseQuantity(int index) {
    if (quantities[index] > 0) {
      setState(() {
        quantities[index]--;
        updateTotal();
      });
    }
  }

  void updateTotal() {
    total = 0;
    for (int i = 0; i < quantities.length; i++) {
      total += quantities[i] * prices[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Color.fromARGB(255, 2, 62, 33),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < quantities.length; i++)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/Iron.jpg",
                        width: 100,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Iron",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Quantity: ${quantities[i]}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Price: \$${quantities[i] * prices[i]}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => increaseQuantity(i),
                            child: const Text("+"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green), // Change color here
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${quantities[i]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => decreaseQuantity(i),
                            child: const Text("-"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green), // Change color here
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Total: \$${total}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Proceed to payment page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(totalAmount: total),
                      ),
                    );
                  },
                  child: const Text('Proceed to Payment'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green), // Change color here
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
