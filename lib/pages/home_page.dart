import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtreasure_recycler/pages/side_pages/profile.dart';
import 'package:trashtreasure_recycler/seller_authentication/login_page.dart';
import '../static/static_shared_preferences.dart';

class Product {
  final int id;
  final String productName;
  final String productType;
  final String imageUrl;
  final String productDescription;
  final int productPrice;

  Product({
    required this.id,
    required this.productName,
    required this.productType,
    required this.imageUrl,
    required this.productDescription,
    required this.productPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? '',
      productType: json['product_type'] ?? '',
      imageUrl: json['image_url'] ?? '',
      productDescription: json['product_description'] ?? '',
      productPrice: json['product_price'] ?? 0,
    );
  }
}

const String _baseUrl = 'http://192.168.56.1:5000';
const String _placeholderImagePath = 'assets/placeholder.jpg';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;
  late TextEditingController _filterController;

  List<Product> _products = [];

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfaWQiOjksImZ1bGxfbmFtZSI6IlNhcGFuYSBSYWkiLCJwaG9uZV9ubyI6Ijk4MTEwMDA2MDAiLCJlbWFpbCI6InNhcGFuYUBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYSQxMCRmRW9WN21VdHY1VjFNc1ZTbWNpYkFPNE1KR3FpYVFJMzRLeGhZb2NsbmlWa1JZLkVYLkNKaSIsInJlc2V0X290cCI6IjAwMDAiLCJyb2xlIjoicmVjeWNsZXIiLCJjcmVhdGVkX2RhdGUiOiIyMDI0LTAzLTE3VDAzOjE1OjU2LjAwMFoiLCJtb2RpZnlfZGF0ZSI6IjIwMjQtMDMtMTdUMDM6MTU6NTYuMDAwWiJ9LCJpYXQiOjE3MTE5NjAzOTcsImV4cCI6MTc0MzQ5NjM5N30.Ek9gzZ7yQ0l9RaaFkxo9cRAy6QoOr0ZU-SpV_IiTywQ";

  @override
  void initState() {
    super.initState();
    fetchData();
    getToken();
    _searchController = TextEditingController();
    _filterController = TextEditingController();
  }

  void getToken() async {
    final SharedPreferences prefs =
        await UserStoragePreferences.getPreferences();
    setState(() {
      token = prefs.getString('token') ?? "";
    });
  }

  // Fetching data
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      if (response.statusCode == 200) {
        setState(() {
          _products = List<Product>.from(json
              .decode(response.body)
              .map((product) => Product.fromJson(product)));
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Handle error gracefully
      // Consider showing a Snackbar or a Dialog to inform the user about the error
    }
  }

  TextEditingController controller = TextEditingController(); //for searching
  List<String> searchResults = [];
  void search(String query) async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.56.1:5000/search?q=$query]'));
      if (response.statusCode == 200) {
        setState(() {
          searchResults = List<String>.from(json.decode(response.body));
        });
      } else {
        print('Failed to load search results: ${response.statusCode}');
        // Handle server error gracefully, for example:
        // setState(() {
        //   searchResults = []; // Clear previous results
        // });
      }
    } catch (e) {
      print('Failed to load search results: $e');
      // Handle network error gracefully, for example:
      // setState(() {
      //   searchResults = []; // Clear previous results
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 62, 33),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 25, 10),
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
                border: Border.all(
                  color: Colors.white70, // Adjust the border color if needed
                  width: 1.0, // Adjust the border width if needed
                ),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.white70,
                    onPressed: _search,
                  ),
                  hintText: 'Search', // Placeholder text
                  hintStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0), // Adjust padding as needed
                  border: InputBorder.none, // Remove TextField's default border
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white70,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Builder(builder: (context) {
        return Drawer(
          child: ListView(children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "TrashTreasure for User",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 2, 62, 33),
              ),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.verified_user_sharp),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.logout),
              onTap: () async {
                final SharedPreferences prefs =
                    await UserStoragePreferences.getPreferences();

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'TrashTreasure',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 2, 62, 33))),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 2, 62, 33))),
                        onPressed: () {
                          prefs.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            )
          ]),
        );
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                crossAxisSpacing: 16.0, // Spacing between columns
                mainAxisSpacing: 16.0, // Spacing between rows
                childAspectRatio: 0.7, // Aspect ratio of each item
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle tapping on a product
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: _products[index]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.0)),
                            child: Image.network(
                              _products[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _products[index].productName,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Price: \$${_products[index].productPrice}',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _search() async {
    final keyword = _searchController.text;
    final filter = _filterController.text;
    try {
      final products = await ProductService.searchProducts(keyword, filter);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(products: products),
        ),
      );
    } catch (e) {
      print('Error fetching products: $e');
      // Handle error
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterController.dispose();
    super.dispose();
  }
}

//Search Result
class SearchResultsPage extends StatelessWidget {
  final List<Product> products;

  const SearchResultsPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.productName),
            subtitle: Text(product.productType),
            leading: Image.network(product.imageUrl),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//Product Detail
class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(product.imageUrl),
            Text('Product Name: ${product.productName}'),
            Text('Product Type: ${product.productType}'),

            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

class ProductService {
  static const String baseUrl =
      'http://192.168.56.1:5000'; // Adjust this to your actual backend URL

  static Future<List<Product>> searchProducts(
      String keyword, String filter) async {
    final Uri uri =
        Uri.parse('$baseUrl/products?keyword=$keyword&filter=$filter');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
