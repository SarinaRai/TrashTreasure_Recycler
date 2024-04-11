import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trashtreasure_recycler/pages/chat.dart';
import 'package:trashtreasure_recycler/pages/payment.dart';

const String _baseUrl = 'http://192.168.56.1:5000';
const String _placeholderImagePath = 'assets/placeholder.jpg';

class TrashSellPage extends StatefulWidget {
  @override
  _TrashSellPageState createState() => _TrashSellPageState();
}

class _TrashSellPageState extends State<TrashSellPage> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String formatUrl(String? url) {
    if (url == null || url.isEmpty) return _placeholderImagePath;
    if (url.startsWith('http')) return url;
    return '$_baseUrl/$url';
  }

  Widget getImage(String? imageUrl) {
    final url = formatUrl(imageUrl);
    return Image.network(
      url,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(_placeholderImagePath);
      },
    );
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/sell_trash'));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Handle error gracefully
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch data. Please try again later.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trash'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: getImage(data[index]['image_url']),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]['trash_name'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Price: \$${data[index]['trash_price'] ?? ''}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Type: ${data[index]['trash_type'] ?? ''}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        data[index]['trash_description'] ?? '',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage()),
                              );
                            },
                            child: Text('Buy'),
                          ),
                          SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(),
                                ),
                              );
                            },
                            child: Text('Chat'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
