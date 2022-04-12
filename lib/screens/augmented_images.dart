import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class AugmentedImage extends StatefulWidget {
  @override
  _AugmentedImageState createState() => _AugmentedImageState();
}

class _AugmentedImageState extends State<AugmentedImage> {
  ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImagesMap = Map();
  HttpClient httpClient;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Augmented Image'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          type: ArCoreViewType.AUGMENTEDIMAGES,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
    arCoreController.onTrackingImage = _handleOnTrackingImage;
    loadSingleImage();
    //OR
    // loadImagesDatabase();
  }

  loadSingleImage() async {
    final ByteData bytes = NetworkAssetBundle(Uri.parse(
            'https://raw.githubusercontent.com/Ahmed2000Github/spring-react/modele/earth_augmented_image.jpg'))
        .load("") as ByteData;
    //     await rootBundle.load('assets/earth_augmented_image.jpg');
    // await rootBundle.load('/storage/emulated/0/Download/images/pic.jpg');
    // await rootBundle.load(
    //     'https://raw.githubusercontent.com/Ahmed2000Github/spring-react/modele/earth_augmented_image.jpg');
    // var url =
    //     'https://raw.githubusercontent.com/Ahmed2000Github/spring-react/modele/earth_augmented_image.jpg';
    // var request = await httpClient.getUrl(Uri.parse(url));
    // var response = await request.close();
    // var bytes = await consolidateHttpClientResponseBytes(response); //Uint8List
    //await rootBundle.load('assets/ear.jpg');
    // await rootBundle.load('assets/earth_augmented_image.jpg');

    arCoreController.loadSingleAugmentedImage(
        bytes: bytes.buffer.asUint8List());
  }

  // loadImagesDatabase() async {
  //   final ByteData bytes = await rootBundle.load('assets/myimages.imgdb');
  //   arCoreController.loadAugmentedImagesDatabase(
  //       bytes: bytes.buffer.asUint8List());
  // }

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.index)) {
      augmentedImagesMap[augmentedImage.index] = augmentedImage;
      _addSphere(augmentedImage);
    }
  }

  Future _addSphere(ArCoreAugmentedImage augmentedImage) async {
    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: augmentedImage.extentX / 2,
    );
    final node = ArCoreNode(
      shape: sphere,
    );
    // final node = ArCoreReferenceNode(
    //     objectUrl:
    //         'https://github.com/Ahmed2000Github/spring-react/blob/modele/Lego.gltf');
    arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
