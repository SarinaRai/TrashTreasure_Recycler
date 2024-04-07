import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trashtreasure_recycler/pages/side_pages/edit.dart';
import 'package:trashtreasure_recycler/seller_authentication/login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> userData = {};
  bool isLoading = true;
  String jwtToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfaWQiOjksImZ1bGxfbmFtZSI6IlNhcGFuYSBSYWkiLCJwaG9uZV9ubyI6Ijk4MTEwMDA2MDAiLCJlbWFpbCI6InNhcGFuYUBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYSQxMCRmRW9WN21VdHY1VjFNc1ZTbWNpYkFPNE1KR3FpYVFJMzRLeGhZb2NsbmlWa1JZLkVYLkNKaSIsInJlc2V0X290cCI6IjAwMDAiLCJyb2xlIjoicmVjeWNsZXIiLCJjcmVhdGVkX2RhdGUiOiIyMDI0LTAzLTE3VDAzOjE1OjU2LjAwMFoiLCJtb2RpZnlfZGF0ZSI6IjIwMjQtMDMtMTdUMDM6MTU6NTYuMDAwWiJ9LCJpYXQiOjE3MTE3MTE3MzEsImV4cCI6MTc0MzI0NzczMX0.HDwcg43Ih-SWx2OyutCatZDQs14F3Jwm6X_n0eRxPp4';
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    String url = 'http://192.168.56.1:5000/profile';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> authData = data['userData'][0];
        final Map<String, dynamic> user = authData;
        setState(() {
          userData = user;
          isLoading = false;
        });
      } else {
        print('Failed to load user data: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() => isLoading = false);
    }
  }

  TextEditingController oldPasswoedController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> changePassword(BuildContext context) async {
    String url = "http://192.168.56.1:5000/change-password/";

    Map<String, String> resetData = {
      'email': emailController.text,
      'oldPassword': oldPasswoedController.text,
      'newPassword': newPasswordController.text,
    };
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(resetData),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        print('successfully reset');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('TrashTreasure'),
            content: const Text('Password has been successfully reset!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 400) {
        print('Please fill all the fields');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('TrashTreasure'),
            content: Text('Please fill all the fields.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 404) {
        print('User not found');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('TrashTreasure'),
            content: Text('User not found'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 401) {
        print('Old password is incorrect');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('TrashTreasure'),
            content: Text('Old password is incorrect'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Password changing failed');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('TrashTreasure'),
            content: Text('Password changing failed'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('An error occurred: $error');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 370,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => "Uplode image",
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/clay.png'), // Provide a default profile picture
                    backgroundColor: Colors.transparent,
                    radius: 20, // Adjust size as needed
                  ),
                ),
                Text(
                  'Name: ${userData['full_name']}',
                  style: TextStyle(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Basic Information",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Name: ${userData['full_name']}',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'PhoneNo: ${userData['phone_no']}',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Email: ${userData['email']}',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 2, 62, 33))),
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPage()),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
            height: 400,
            color: Color.fromARGB(255, 236, 234, 234),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.changePassword,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 3, 71, 131),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      controller: oldPasswoedController,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.currentPassword,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.newPassword,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 80,
                    width: 400,
                    padding: const EdgeInsets.fromLTRB(7, 15, 7, 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 2, 62, 33))),
                      child: Text(
                        AppLocalizations.of(context)!.changePassword,
                        style: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        changePassword(context);
                      },
                    )),
              ],
            )),
      ]),
    );
  }
}
