import 'package:flutter/material.dart';
import 'package:medplants/Form/screen/form_screen.dart';
import 'package:medplants/theme/theme_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().greenBaseColor,
      body: Center(
          child: Image.asset(
        'assets/logo.png',
        width: 350,
        height: 350,
      )),
    );
  }
}