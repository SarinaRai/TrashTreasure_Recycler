import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String _baseUrl = 'http://192.168.56.1:5000';
const String _placeholderImagePath =
    'assets/placeholder.jpg'; // Ensure you have a placeholder image in your assets

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String formatUrl(String? url) {
    if (url == null || url.isEmpty) return _placeholderImagePath;
    if (url.startsWith('http')) return url; // Return the URL if it's a full URL
    return '$_baseUrl/$url'; // Return the concatenated URL if it's a partial path
  }

  Widget getImage(String? imageUrl) {
    print(imageUrl);
    final url = formatUrl(imageUrl);
    return Image.network(url, errorBuilder: (context, error, stackTrace) {
      // If the network image fails to load, use a placeholder
      return Image.asset(_placeholderImagePath);
    });
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Consider showing a Snackbar or a Dialog to inform the user about the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 62, 33),
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4.0), // Added for better UI
              child: getImage(data[index]['image_url']),
            ),
            title: Text(data[index]['product_name'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data[index]['product_description'] ?? ''),
                SizedBox(height: 5),
                Text('Price: \$${data[index]['product_price'] ?? ''}'),
                Text('Type: ${data[index]['product_type'] ?? ''}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
