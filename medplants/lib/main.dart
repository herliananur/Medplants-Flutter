import 'package:flutter/material.dart';
import 'package:medplants/model/app_model.dart';
import 'package:medplants/screen/home_page.dart';
import 'package:medplants/screen/med_screen.dart';
import 'package:medplants/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppModel(),
    child: MyApp(),
  ), );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/homePage': (context) => HomePage(),
        '/medScreen': (context) => MedScreen(),
      },
    );
  }
}
