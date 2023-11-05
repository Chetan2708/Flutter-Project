import 'package:flutter/material.dart';
import 'colors.dart';

import 'main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Text Extraction'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 0, 0, 0),
          ]),
        ),
        child: const Center(
          child: Text(
            "SmartCert",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Pallete.whiteColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
