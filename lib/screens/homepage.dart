import 'package:flutter/material.dart';

import 'components/photoList.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

const RoundedRectangleBorder roundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)));

class _HomePageState extends State<HomePage> {
  bool isSoloViewMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        shape: roundedRectangleBorder,
        leading: Icon(Icons.photo_album),
        title: Text('Photo Gallery'),
        actions: <Widget>[
          IconButton(
            icon: isSoloViewMode
                ? Icon(Icons.view_array)
                : Icon(Icons.view_module),
            onPressed: () {
              setState(() {
                isSoloViewMode = !isSoloViewMode;
              });
            },
          )
        ],
      ),
      body: PhotoList(
        isSoloViewMode: isSoloViewMode,
      ),
    );
  }
}
