import 'package:flutter/material.dart';
import 'package:medplants/API_plant/model/med_screen_viewmodel.dart';
import 'package:medplants/classifier/model/image_classification_viewmodel.dart';
import 'package:medplants/classifier/screen/image_classification_screen.dart';
import 'package:medplants/model/app_model.dart';
import 'package:medplants/screen/home_page.dart';
import 'package:medplants/API_plant/screen/med_screen.dart';
import 'package:medplants/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => MedScreenViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => ImageClassificationViewModel(),
      ),
    ],
    child: const MyApp(),
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
        '/': (context) => const SplashScreen(),
        '/homePage': (context) => const HomePage(),
        '/medScreen': (context) => const MedScreen(),
        '/upScreen': (context) => const ImageClassificationScreen(),
        // '/botScreen': (context) => PlantBotScreen(),
      },
    );
  }
}
