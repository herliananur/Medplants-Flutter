import 'package:flutter/material.dart';
import 'package:medplants/model/app_model.dart';
import 'package:medplants/theme/theme_color.dart';
import 'package:medplants/theme/theme_text_style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      // appBar: AppBar(backgroundColor: ThemeColor().greenBaseColor,),
      backgroundColor: ThemeColor().greenBaseColor,

      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CustomButton(
                labelText: "Upload Gambar",
                imagePath: 'assets/up-logo.png',
                onPressed: () {
                  appModel.navigateToMedScreen();
                  Navigator.pushNamed(context, '/upScreen');
                }),
            CustomButton(
                labelText: "Ambil Gambar",
                imagePath: 'assets/cam-logo.png',
                onPressed: () {}),
            CustomButton(
                labelText: "Tanaman Obat",
                imagePath: 'assets/med-logo.png',
                onPressed: () {
                  appModel.navigateToMedScreen();
                  Navigator.pushNamed(context, '/medScreen');
                }),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String labelText;
  final String imagePath;
  final VoidCallback onPressed;

  CustomButton({
    required this.labelText,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 325,
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ThemeColor().greenTransparant,
          ),
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 60,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                labelText,
                style: ThemeTextStyle().judulText,
              )
            ],
          ),
        ),
      ),
    );
  }
}


// class MyCard extends StatelessWidget {
//   final String logoImage;
//   final String title;

//   const MyCard(this.logoImage, this.title, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(25),
//             child: Image.asset('assets/$logoImage'),
//           ),
//           ListTile(
//             title: Center(
//                 child: Text(
//               title,
//               style: ThemeTextStyle().judulText,
//             )),
//           )
//         ],
//       ),
//     );
//   }
// }
