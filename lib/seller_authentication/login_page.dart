// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtreasure_recycler/controller/language_controller.dart';
import 'package:trashtreasure_recycler/pages/nav_page.dart';
import 'package:trashtreasure_recycler/seller_authentication/forgot_password.dart';
import 'package:trashtreasure_recycler/seller_authentication/register_page.dart';

import '../static/static_shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _ChangeLanguageState();
}

enum Language { engilsh, nepali }

class _ChangeLanguageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(context) async {
    String url = 'http://192.168.18.202:5000/login/';

    Map<String, String> loginData = {
      'email': emailController.text,
      'password': passwordController.text
    };

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(loginData),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        // SharedPreferences preferences = S
        final SharedPreferences prefs =
            await UserStoragePreferences.getPreferences();
        final body = jsonDecode(response.body);
        prefs.setString('token', body['token']);
        print(body);
        print("Login Successfully");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text('Login Successful'),
            actions: [
              ElevatedButton(
                // onPressed: () => Navigator.pop(context),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
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
        print('Invalid password');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text('Invalid password.'),
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
        print('Login failed');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TrashTreasure'),
            content: const Text(
                'An error occurred while logging in. Please try again later.'),
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.chooseLanguage,
        ),
        backgroundColor: const Color.fromARGB(255, 2, 62, 33),
        actions: [
          Consumer<LanguageChangeController>(
              builder: (context, provider, child) {
            return PopupMenuButton(
                onSelected: (Language item) {
                  if (Language.engilsh.name == item.name) {
                    provider.changeLanguage(const Locale('en'));
                  } else {
                    print('nepali');
                    provider.changeLanguage(const Locale('ne'));
                  }
                },
                itemBuilder: (BuildContext contex) =>
                    <PopupMenuEntry<Language>>[
                      const PopupMenuItem(
                        value: Language.engilsh,
                        child: Text('English'),
                      ),
                      const PopupMenuItem(
                        value: Language.nepali,
                        child: Text('Nepali'),
                      )
                    ]);
          })
        ],
      ),
      body: ListView(children: [
        Image.asset('assets/logo.png'),
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
        Container(
            height: 80,
            width: 355,
            padding: const EdgeInsets.fromLTRB(7, 10, 7, 10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 2, 62, 33))),
              child: Text(
                AppLocalizations.of(context)!.logIn,
                style: const TextStyle(fontSize: 20),
              ),
              onPressed: () => loginUser(context),
              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => MainPage()),
              //   );
              // },
            )),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.forgot,
            style: const TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 2, 62, 33)),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPage(),
                ));
          },
        ),
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
    );
  }
}
