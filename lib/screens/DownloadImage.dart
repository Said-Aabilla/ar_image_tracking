import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download images"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => onClick(),
          child: Text('Download'),
        ),
      ),
    );
  }

  List<String> _folders;
  Future<void> getDir() async {
    // final directory = await DownloadsPathProvider.downloadsDirectory;
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    // String pdfDirectory = '$dir/modeles';
    String pdfDirectory = '$dir/images';
    final myDir = new Directory(pdfDirectory);
    // setState(() {
    List<String> list = List();
    var folders = myDir.listSync(recursive: true, followLinks: false);
    for (var folder in folders) {
      list.add(folder.path);
    }
    _folders = list;
    // });
    print(folders.first.path);
  }

  onClick() {
    getDir();
    print("Download completed");
  }
}
