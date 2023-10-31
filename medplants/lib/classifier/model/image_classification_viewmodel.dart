import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ImageClassificationViewModel with ChangeNotifier {
  XFile? _image;
  XFile? get image => _image;

  List<dynamic>? _outputs;
  List<dynamic>? get outputs => _outputs;

  final ImagePicker _picker = ImagePicker();

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.1,
      imageMean: 0.0,
      imageStd: 255.0,
    );

    _outputs = output;
    _image = image;
    notifyListeners();
  }

  Future<void> openCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      await classifyImage(image);
    }
  }

  Future<void> openGallery() async {
    var picture = await _picker.pickImage(source: ImageSource.gallery);

    if (picture != null) {
      await classifyImage(picture);
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
