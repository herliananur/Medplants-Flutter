// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:medplants/classifier/tflite_jadi.dart';
// import 'package:medplants/plantbot/plant_bot_screen.dart';
// import 'package:medplants/profile/profile_screen.dart';
// import 'package:medplants/screen/home_page.dart';
// import 'package:medplants/screen/med_screen.dart';
// import 'package:medplants/theme/theme_color.dart';

// class BottomNavWidget extends StatefulWidget {
//   const BottomNavWidget({
//     Key? key,
//     required this.currentIndex,
//   }) : super(key: key);

//   final int currentIndex;

//   @override
//   State<BottomNavWidget> createState() => _BottomNavWidgetState();
// }

// class _BottomNavWidgetState extends State<BottomNavWidget> {
//   int currentIndex = 0;
//   final screens = [
//     TfliteJadii(),
//     MedScreen(),
//     PlantBotScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: currentIndex,
//         children: screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: ThemeColor().greenTransparant,
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white70,
//           iconSize: 40,
//           // selectedFontSize: 25,
//           // unselectedFontSize: 16,
//           showSelectedLabels: true,
//           showUnselectedLabels: false,
//           currentIndex: currentIndex,
//           onTap: (index) => setState(() => currentIndex = index),
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_max_rounded),
//               label: 'Home',
//               // backgroundColor: ThemeColor().greenTransparant,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.library_books_rounded),
//               label: 'Library',
//               // backgroundColor: ThemeColor().greenTransparant,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat_bubble_rounded),
//               label: 'PlantBot',
//               // backgroundColor: ThemeColor().greenTransparant,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//               // backgroundColor: ThemeColor().greenTransparant,
//             ),
//           ]),
//     );
//   }
// }
