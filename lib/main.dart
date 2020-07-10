import 'package:flutter/material.dart';
import 'screens/homepage.dart';

void main() => runApp(PhotoGalleryApp());

class PhotoGalleryApp extends StatelessWidget {
  const PhotoGalleryApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(253, 217, 181, 1),
        backgroundColor: Color.fromRGBO(253, 217, 181, .85),
      ),
      home: HomePage(),
    );
  }
}
