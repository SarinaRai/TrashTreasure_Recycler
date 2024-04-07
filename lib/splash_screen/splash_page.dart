import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcom To',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 3, 71, 131),
                    fontWeight: FontWeight.w500),
              ),
              Image(
                image: AssetImage('assets/logo.png'),
                height: 200,
                width: 300,
              ),
              Text(
                'Trash for Cash, Good for Earth',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 3, 71, 131),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
