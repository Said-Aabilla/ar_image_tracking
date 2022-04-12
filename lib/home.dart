// import 'package:arcore_flutter_plugin_example/screens/GetImage.dart';
// import 'package:arcore_flutter_plugin_example/screens/augmented_images.dart';
// import 'package:arcore_flutter_plugin_example/screens/multiple_augmented_images.dart';
import 'package:flutter/material.dart';

import 'screens/DownloadImage.dart';
import 'screens/GetImage.dart';
import 'screens/augmented_images.dart';
import 'screens/multiple_augmented_images.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArCore Demo'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => GetImage()));
            },
            title: Text("GetImage"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DownloadImage()));
            },
            title: Text("DownloadImage"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AugmentedImage()));
            },
            title: Text("Augmented Image"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultipleAugmentedImagesPage()));
            },
            title: Text("Multiple augmented images"),
          ),
         
        ],
      ),
    );
  }
}
