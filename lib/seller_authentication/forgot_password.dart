// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trashtreasure_recycler/seller_authentication/register_page.dart';
import 'package:trashtreasure_recycler/seller_authentication/reset_password.dart';

// ignore: must_be_immutable
class ForgotPage extends StatelessWidget {
  ForgotPage({super.key});
  TextEditingController emailController = TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    String url = "http://192.168.18.202:5000/forgot-password";

    Map<String, String> resetData = {
      'email': emailController.text,
    };

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(resetData),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print('token send to mail');
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("TrashTreasure"),
            content:
                const Text('Password reset token has been sent to your email'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 400) {
        print('Please provide an email address');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text('Please provide an email address'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 404) {
        print("User doesn't exist");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text("User doesn't exist."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Sending failed');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text('Sending Failed'),
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
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('asset/logo.png'))),
          ),
          // Images.asset(),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Trash for Cash, Good for Earth",
              style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 3, 71, 131),
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Forgot Password",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 3, 71, 131)),
              ),
            ),
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
          Container(
              height: 80,
              width: 355,
              padding: const EdgeInsets.fromLTRB(7, 10, 7, 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 2, 62, 33))),
                child: Text(
                  AppLocalizations.of(context)!.sendMail,
                  style: const TextStyle(fontSize: 20),
                ),
                onPressed: () => resetPassword(context),
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
