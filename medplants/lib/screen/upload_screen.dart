import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<dynamic> _output = [];
  File? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void loadModel() async {
    await Tflite.loadModel(
      model: 'assets/medplants.tflite',
      labels: 'assets/label.txt',
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future<void> _classifyImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      _loading = true;
      _image = File(image.path);
    });

    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2, //jumlah hasil klasifikasi yang diinginkan
    );

    setState(() {
      _loading = false;
      _output = output ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? Text('Pilih Gambar') : Image.file(_image!),
            SizedBox(
              height: 16,
            ),
            _loading
                ? CircularProgressIndicator()
                : _output.isNotEmpty
                    ? Text(
                        _output[0]['label'],
                      )
                    : Text('Tidak ada hasil klasifikasi'),
            ElevatedButton(
              onPressed: _classifyImage,
              child: Text('Unggah gambar'),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

// class UploadScreen extends StatefulWidget {
//   const UploadScreen({super.key});

//   @override
//   State<UploadScreen> createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   late File pickedImage;
//   bool isImageLoaded = false;

//   late List _result;
//   String _confidence = '';
//   String _name = '';

//   String numbers = '';

//   getImageFromGallery() async {
//     var tempStore = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (tempStore != null) {
//       setState(() {
//         pickedImage = File(tempStore.path);
//         isImageLoaded = true;
//       });
//     }
//     // setState(() {
//     //   pickedImage = File(tempStore.path);
//     //   isImageLoaded = true;
//     // });
//   }

//   loadMyModel() async {
//     var resultant = await Tflite.loadModel(
//       model: 'assets/medplants.tflite',
//       labels: 'assets/label.txt',
//     );

//     print('Result after loading model: $resultant');
//   }

//   applyModelOnImage(File file) async {
//     var res = await Tflite.runModelOnImage(
//       path: file.path,
//       numResults: 2,
//       threshold: 0.5,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     setState(() {
//       _result = res!;

//       String str = _result[0]['label'];

//       _name = str.substring(2);

//       _confidence = _result != null
//           ? (_result[0]['confidence'] * 100.0).toString().substring(0, 2) + '%'
//           : '';
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadMyModel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Screen'),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             isImageLoaded
//                 ? Center(
//                     child: Container(
//                       height: 350,
//                       width: 350,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: FileImage(File(pickedImage.path)),
//                               fit: BoxFit.contain)),
//                     ),
//                   )
//                 : Container(),
//             SizedBox(
//               height: 30,
//             ),
//             Text('Name: $_name \nConfidence: $_confidence')
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           getImageFromGallery();
//         },
//         child: Icon(Icons.photo_album),
//       ),
//     );
//   }
// }
