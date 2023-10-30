import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medplants/theme/theme_color.dart';
import 'package:tflite/tflite.dart';

class TfliteJadii extends StatefulWidget {
  const TfliteJadii({super.key});

  @override
  State<TfliteJadii> createState() => _TfliteJadiiState();
}

class _TfliteJadiiState extends State<TfliteJadii> {
  XFile? _image;
  List<dynamic>? _outputs;

  //Load the Tflite model
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  classifyImage(image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.1,
      imageMean: 0.0,
      imageStd: 255.0,
    );
    setState(() {
      //declare list _outputs in the class which will be used to show the classified class name dan confidence
      _outputs = output;
      //
      _image = image;
    });
  }

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification'),
        backgroundColor: ThemeColor().greenBaseColor,
      ),
      body: _image == null
          ? Container(
              alignment: Alignment.center,
              child: Text('No image selected.'),
              // child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null ? Container() : Image.file(File(_image!.path)),
                  SizedBox(
                    height: 20,
                  ),
                  _outputs != null
                      ? Text(
                          '${_outputs![0]["label"]}',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      : Container()
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _optiondialogbox,
        backgroundColor: ThemeColor().greenTransparant,
        child: Icon(Icons.image),
      ),
    );
  }

  //camera method
  Future<void> _optiondialogbox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeColor().greenTransparant,
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                GestureDetector(
                  child: Text(
                    'Take a picture',
                    style:
                        TextStyle(color: ThemeColor().blackColor, fontSize: 20),
                  ),
                  onTap: openCamera,
                ),
                Padding(padding: EdgeInsets.all(10)),
                GestureDetector(
                  child: Text(
                    'Select Image',
                    style: TextStyle(
                      color: ThemeColor().blackColor,
                      fontSize: 20,
                    ),
                  ),
                  onTap: openGallery,
                )
              ],
            )),
          );
        });
  }

  Future openCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return;
    classifyImage(image);
    // setState(() {
    //   _image = image;
    // });
  }

  Future openGallery() async {
    var picture = await _picker.pickImage(source: ImageSource.gallery);

    if (picture == null) return;
    classifyImage(picture);
    // setState(() {
    //   _image = XFile(picture!.path);
    // });
  }
}
