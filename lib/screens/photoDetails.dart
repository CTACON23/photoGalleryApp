import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'components/methods/showToast.dart';

class PhotoDetails extends StatefulWidget {
  final dynamic data;

  PhotoDetails({Key key, this.data}) : super(key: key);

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: Icon(Icons.photo_album),
          title: Text('Photo Gallery'),
        ),
        body: GestureDetector(
          child: Center(child: Image.network(widget.data.urlFull)),
          onDoubleTap: () {
            setState(() {
              widget.data.like = !widget.data.like;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context, widget.data.like);
          },
        ));
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showToast(
        'Double Tap if you like it!', context,
        gravity: Toast.BOTTOM, duration: 3));
  }
}
