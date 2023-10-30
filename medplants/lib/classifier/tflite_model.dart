import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TfliteModel extends StatefulWidget {
  const TfliteModel({super.key});

  @override
  State<TfliteModel> createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
   File? _image;
   List? _results;
  bool imageSelect = false;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    await Tflite.close();
    String res;
    res = (await Tflite.loadModel(
      model: 'assets/medplants.tflite',
      labels: 'assets/label.txt',
    ))!;
    print('Models loading status: $res');
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Classification'),
      ),
      body: ListView(
        children: [
          (imageSelect)
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.file(_image!),
                )
              : Container(
                  margin: const EdgeInsets.all(10),
                  child: const Opacity(
                    opacity: 0.8,
                    child: Center(
                      child: Text('No Image Selected'),
                    ),
                  ),
                ),
          SingleChildScrollView(
              child: Column(
                  children: (imageSelect)
                      ? _results!.map(
                          (result) {
                            return Card(
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  '${result[0]['label']}',
                                  // '${result['label']} - ${result['confidence'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ),
                            );
                          },
                        ).toList()
                      : []))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "Pick Image",
        child: const Icon(Icons.image),
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File? image = pickedFile?.path != null ? File(pickedFile!.path) : null;
    if (image != null) {
      imageClassification(image);
    }
    // File image = File(pickedFile!.path);
    // imageClassification(image);
  }
}
