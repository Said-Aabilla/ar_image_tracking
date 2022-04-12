import 'dart:typed_data';

import 'package:arcore_flutter_plugin_example/models/distant_image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MultipleAugmentedImagesPage extends StatefulWidget {
  @override
  _MultipleAugmentedImagesPageState createState() =>
      _MultipleAugmentedImagesPageState();
}

class _MultipleAugmentedImagesPageState
    extends State<MultipleAugmentedImagesPage> {
  ArCoreController arCoreController;
  Map<String, ArCoreAugmentedImage> augmentedImagesMap = Map();
  Map<String, Uint8List> bytesMap = Map();

  List<DsitantImageAsset> distantImages = [
    DsitantImageAsset(
        id: "1",
        imageLink:
            "https://github.com/Ahmed2000Github/spring-react/blob/modele/earth_augmented_image.jpg?raw=true",
        imageName: "earth_augmented_image",
        modelLink:
            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf"),
    DsitantImageAsset(
        id: "2",
        imageLink:
            "https://github.com/Ahmed2000Github/spring-react/blob/modele/earth_augmented_image.jpg?raw=true",
        imageName: "prova_texture",
        modelLink:
            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Multiple augmented images'),
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
    loadMultipleImage();
  }

  loadMultipleImage() async {
    for (var asset in distantImages) {
      final ByteData bytes =
          await NetworkAssetBundle(Uri.parse(asset.imageLink)).load("");
      bytesMap[asset.imageName] = bytes.buffer.asUint8List();
    }

    // final ByteData bytes1 = await NetworkAssetBundle(Uri.parse(
    //         'https://github.com/Ahmed2000Github/spring-react/blob/modele/earth_augmented_image.jpg?raw=true'))
    //     .load("");
    // final ByteData bytes2 = await rootBundle.load('assets/prova_texture.png');
    // final ByteData bytes3 = await rootBundle.load('assets/umano_digitale.png');
    // bytesMap["earth_augmented_image"] = bytes1.buffer.asUint8List();
    // bytesMap["prova_texture"] = bytes2.buffer.asUint8List();
    // bytesMap["umano_digitale"] = bytes3.buffer.asUint8List();

    arCoreController.loadMultipleAugmentedImage(bytesMap: bytesMap);
  }

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.name)) {
      augmentedImagesMap[augmentedImage.name] = augmentedImage;

      _addModel(augmentedImage);
    }
  }

  Future _addModel(ArCoreAugmentedImage augmentedImage) async {
    for (var asset in distantImages) {
      if (asset.imageName == augmentedImage.name) {
        final node = ArCoreReferenceNode(
            objectUrl:
                'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf');

        arCoreController.addArCoreNodeToAugmentedImage(
            node, augmentedImage.index);
      }
    }
  }

  // Future _addSphere(ArCoreAugmentedImage augmentedImage) async {
  // final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

  // final material = ArCoreMaterial(
  //   color: Color.fromARGB(120, 66, 134, 244),
  //   textureBytes: textureBytes.buffer.asUint8List(),
  // );
  // final sphere = ArCoreSphere(
  //   materials: [material],
  //   radius: augmentedImage.extentX / 2,
  // );
  // final node = ArCoreNode(
  //   shape: sphere,
  // );

  //  "https://github.com/Ahmed2000Github/spring-react/blob/modele/uploads_files_2894278_Robot.glb",
  //   final node = ArCoreReferenceNode(
  //       objectUrl:
  //           'https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf');

  //   arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
  // }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
