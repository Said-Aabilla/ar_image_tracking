// import 'package:arcore_flutter_plugin_example/screens/GetImage.dart';
// import 'package:arcore_flutter_plugin_example/screens/augmented_images.dart';
// import 'package:arcore_flutter_plugin_example/screens/multiple_augmented_images.dart';
import 'package:flutter/material.dart';

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
