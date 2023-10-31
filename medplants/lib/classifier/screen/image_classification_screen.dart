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
    // imageClassificationViewModel =
    //     Provider.of<ImageClassificationViewModel>(context);

    // imageClassificationViewModel.loadModel();
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
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Gallery'),
        ],
      ),
      // imageClassificationViewModel.image == null
      //     ? Container(
      //         alignment: Alignment.center,
      //         child: Text('No image selected.'),
      //       )
      //     : SingleChildScrollView(
      //         // width: MediaQuery.of(context).size.width,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             imageClassificationViewModel.image == null
      //                 ? Container()
      //                 : Image.file(
      //                     File(imageClassificationViewModel.image!.path)),
      //             SizedBox(
      //               height: 16,
      //             ),
      //             imageClassificationViewModel.outputs != null
      //                 ? Text(
      //                     '${imageClassificationViewModel.outputs![0]["label"]}',
      //                     style: TextStyle(
      //                         color: ThemeColor().blackColor, fontSize: 20),
      //                   )
      //                 : Container()
      //           ],
      //         ),
      //       ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ElevatedButton(
      //       onPressed: imageClassificationViewModel.openCamera,
      //       style: ElevatedButton.styleFrom(
      //           backgroundColor: ThemeColor().greenTransparant),
      //       child: Icon(Icons.camera_alt),
      //     ),
      //     SizedBox(
      //       width: 16,
      //     ),
      //     ElevatedButton(
      //       onPressed: imageClassificationViewModel.openGallery,
      //       style: ElevatedButton.styleFrom(
      //           backgroundColor: ThemeColor().greenTransparant),
      //       child: Icon(Icons.photo),
      //     ),
      // FloatingActionButton(
      //   onPressed: imageViewModel.openCamera,
      //   backgroundColor: ThemeColor().greenTransparant,
      //   child: Icon(Icons.camera_alt),
      // ),
      // FloatingActionButton(
      //   onPressed: imageViewModel.openGallery,
      //   backgroundColor: ThemeColor().greenTransparant,
      //   child: Icon(Icons.image),
      // ),
      // ],
    );
    // );
    // _image == null
    //     ? Container(
    //         alignment: Alignment.center,
    //         child: const Text('No image selected.'),
    //       )
    //     : Container(
    //         width: MediaQuery.of(context).size.width,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             _image == null ? Container() : Image.file(File(_image!.path)),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             _outputs != null
    //                 ? Text(
    //                     '${_outputs![0]["label"]}',
    //                     style: const TextStyle(
    //                         color: Colors.black, fontSize: 20),
    //                   )
    //                 : Container()
    //           ],
    //         ),
    //       ),
    // floatingActionButton: FloatingActionButton(
    //   onPressed: _optiondialogbox,
    //   backgroundColor: ThemeColor().greenTransparant,
    //   child: const Icon(Icons.image),
    // ),
    // );
  }

  Widget _buildPage(int index) {
    if (index == 0) {
      return _buildCameraPage();
    } else if (index == 1) {
      return _buildGalleryPage();
    }
    return Container(); // Tambahkan halaman lain jika diperlukan
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
          SizedBox(
            height: 16,
          ),
          imageClassificationViewModel.outputs != null
              ? Text(
                  '${imageClassificationViewModel.outputs![0]["label"]}',
                  style:
                      TextStyle(color: ThemeColor().blackColor, fontSize: 20),
                )
              : Container(),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: imageClassificationViewModel.openCamera,
            style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor().greenTransparant),
            child: Text('Open Camera'),
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
          SizedBox(
            height: 16,
          ),
          imageClassificationViewModel.outputs != null
              ? Text(
                  '${imageClassificationViewModel.outputs![0]["label"]}',
                  style:
                      TextStyle(color: ThemeColor().blackColor, fontSize: 20),
                )
              : Container(),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: imageClassificationViewModel.openGallery,
            style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor().greenTransparant),
            child: Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
