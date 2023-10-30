import 'package:flutter/material.dart';
import 'package:medplants/classifier/image_classification_screen.dart';
import 'package:medplants/model/app_model.dart';
import 'package:medplants/screen/home_page.dart';
import 'package:medplants/API_plant/med_screen.dart';
import 'package:medplants/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/homePage': (context) => HomePage(),
        '/medScreen': (context) => PlantList(),
        '/upScreen': (context) => ImageClassificationScreen(),
        // '/botScreen': (context) => PlantBotScreen(),
      },
    );
  }
}
