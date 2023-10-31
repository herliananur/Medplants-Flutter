import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medplants/classifier/model/image_classification_viewmodel.dart';
import 'package:medplants/theme/theme_color.dart';
import 'package:provider/provider.dart';

class ImageClassificationScreen extends StatefulWidget {
  const ImageClassificationScreen({super.key});

  @override
  State<ImageClassificationScreen> createState() =>
      _ImageClassificationScreenState();
}

class _ImageClassificationScreenState extends State<ImageClassificationScreen> {
  late ImageClassificationViewModel imageClassificationViewModel;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageClassificationViewModel =
        Provider.of<ImageClassificationViewModel>(context);

    imageClassificationViewModel.loadModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Classification'),
        backgroundColor: ThemeColor().greenBaseColor,
      ),
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Gallery'),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    if (index == 0) {
      return _buildCameraPage();
    } else if (index == 1) {
      return _buildGalleryPage();
    }
    return Container();
  }

  Widget _buildCameraPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageClassificationViewModel.image == null
              ? Container()
              : Image.file(File(imageClassificationViewModel.image!.path)),
          const SizedBox(
            height: 16,
          ),
          imageClassificationViewModel.outputs != null
              ? Text(
                  '${imageClassificationViewModel.outputs![0]["label"]}',
                  style:
                      TextStyle(color: ThemeColor().blackColor, fontSize: 20),
                )
              : Container(),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: imageClassificationViewModel.openCamera,
            style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor().greenTransparant),
            child: const Text('Open Camera'),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageClassificationViewModel.image == null
              ? Container()
              : Image.file(File(imageClassificationViewModel.image!.path)),
          const SizedBox(
            height: 16,
          ),
          imageClassificationViewModel.outputs != null
              ? Text(
                  '${imageClassificationViewModel.outputs![0]["label"]}',
                  style:
                      TextStyle(color: ThemeColor().blackColor, fontSize: 20),
                )
              : Container(),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: imageClassificationViewModel.openGallery,
            style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor().greenTransparant),
            child: const Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
