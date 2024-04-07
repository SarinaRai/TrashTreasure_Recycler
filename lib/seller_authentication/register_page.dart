// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trashtreasure_recycler/seller_authentication/login_page.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    String url = "http://192.168.56.1:5000/register/";

    Map<String, String> registrationData = {
      'full_name': fullNameController.text,
      'email': emailController.text,
      'phone_no': phoneController.text,
      'password': passwordController.text,
      'confirmPassword': confirmController.text,
      'role': roleController.text
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(registrationData),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print('User registered successfully');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("TrashTreasure"),
            content: const Text('Register Successfully'),
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
            title: const Text('TrashTreasure'),
            content: const Text('Please fill all the fields.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 401) {
        print("Password doesn't match");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text("Password doesn'n match"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 403) {
        print("Phone number should be 10 digits");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text("Phone number should be 10 digits"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 404) {
        print("Invalid email address");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text("Invalid email address"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 402) {
        print("User already exists");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text("User already exists"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Register failed');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text('An error occur, please try in later'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('An error occurred: $error');
      // Handle any error that occurs during registration
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Trash Treasure',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 2, 62, 33)),
              ),
            ),
          ),
          Center(
            child: Text(
              'Register as recycler',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 2, 62, 33)),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(AppLocalizations.of(context)!.fullName)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(AppLocalizations.of(context)!.email)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(AppLocalizations.of(context)!.phone)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(AppLocalizations.of(context)!.role)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(AppLocalizations.of(context)!.password)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(AppLocalizations.of(context)!.confirm)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: SizedBox(
              height: 45,
              child: TextField(
                controller: confirmController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Container(
              height: 75,
              width: 355,
              padding: const EdgeInsets.fromLTRB(7, 15, 7, 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 2, 62, 33))),
                child: Text(
                  AppLocalizations.of(context)!.register,
                  style: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  registerUser(context);
                },
              )),
          Row(
            // ignore: sort_child_properties_last
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.haveAccount,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.logIn,
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 2, 62, 33)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      )),
    );
  }
}
