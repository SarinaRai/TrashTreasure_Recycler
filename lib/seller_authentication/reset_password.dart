// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trashtreasure_recycler/seller_authentication/login_page.dart';
import 'package:trashtreasure_recycler/seller_authentication/register_page.dart';

// ignore: must_be_immutable
class ResetPage extends StatelessWidget {
  ResetPage({super.key});

  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> recoverPassword(BuildContext context) async {
    String url = "http://192.168.18.202:5000/reset-password/";

    Map<String, String> resetData = {
      'email': emailController.text,
      'reset_otp': codeController.text,
      'password': passwordController.text,
      'confirmPassword': confirmController.text,
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
            title: const Text('TrashTreasure'),
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
      } else if (response.statusCode == 404) {
        print('Invalid email or otp token');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text('Invalid email or otp token'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Password reset failed');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text('Password reset failed'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.recoveryPassword,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 3, 71, 131),
                  ),
                )),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(AppLocalizations.of(context)!.email)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(AppLocalizations.of(context)!.enterCode)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: codeController,
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
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: SizedBox(
              height: 60,
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
              child: Text(
                AppLocalizations.of(context)!.confirm,
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: confirmController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Container(
              height: 80,
              width: 355,
              padding: const EdgeInsets.fromLTRB(7, 10, 7, 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 2, 62, 33))),
                child: Text(
                  AppLocalizations.of(context)!.reset,
                  style: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  recoverPassword(context);
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.donotAccount,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.register,
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 2, 62, 33)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ));
                },
              )
            ],
          ),
        ]),
      ),
    );
  }
}
