import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' show get;
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class GetImage extends StatefulWidget {
  Future<void> requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  State<StatefulWidget> createState() {
    requestPermission();
    return _MyHomePageState();
  }
}


class _MyHomePageState extends State<GetImage> {
  @override
  initState() {
    _asyncMethod();
    super.initState();
  }

  _asyncMethod() async {
    var url = Uri.parse(
        "https://github.com/Ahmed2000Github/spring-react/blob/modele/earth_augmented_image.jpg?raw=true"); // <-- 1
        // "https://github.com/Ahmed2000Github/spring-react/blob/modele/Lego.gltf"); // <-- 1
    var response = await get(url); // <--2
    // var documentDirectory = await DownloadsPathProvider.downloadsDirectory;
    var documentDirectory = await getApplicationDocumentsDirectory();
    print(documentDirectory);
    var firstPath = documentDirectory.path + "/images";
    // var firstPath2 = documentDirectory.path + "/modeles";
    var filePathAndName = documentDirectory.path + '/images/pic.jpg';
    // var filePathAndName2 = documentDirectory.path + '/modeles/mod.gltf';
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet
    await Directory(firstPath).create(recursive: true); // <-- 1
    // File file2 = new File(filePathAndName); // <-- 2
    File file3 = new File(filePathAndName); // <-- 2
    // file2.writeAsBytesSync(response.bodyBytes); // <-- 3
    file3.writeAsBytesSync(response.bodyBytes); // <-- 3
    print(response.bodyBytes);
    setState(() {
      imageData = filePathAndName;
      dataLoaded = true;
    });
  }

  String imageData;
  bool dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (dataLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: Text("widget.title"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.file(File(imageData), width: 300.0, height: 390.0)
            ],
          ),
        ),
      );
    } else {
      return CircularProgressIndicator(
        backgroundColor: Colors.cyan,
        strokeWidth: 5,
      );
    }
  }
}
