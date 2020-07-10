import 'package:flutter/material.dart';

class PhotoCard extends StatefulWidget {
  final dynamic data;
  final typeVeiw;
  PhotoCard({Key key, this.data, this.typeVeiw}) : super(key: key);

  @override
  _PhotoCardState createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Card(
          color: Color.fromRGBO(250, 235, 215, 1),
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.network(widget.data.urlSmall),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Text(widget.data.name,
                      style: widget.typeVeiw
                          ? TextStyle(fontSize: 10)
                          : TextStyle(fontSize: 15)),
                ),
              ),
              ListTile(
                  trailing: SizedBox(
                      height: 60,
                      width: widget.typeVeiw ? 25 : 30,
                      child: IconButton(
                        iconSize: widget.typeVeiw ? 20 : 30,
                        icon: Icon(Icons.favorite),
                        color: widget.data.like ? Colors.red : Colors.black,
                        onPressed: () {
                          setState(() {
                            widget.data.like = !widget.data.like;
                          });
                        },
                      )),
                  leading: Text(widget.data.author,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: widget.typeVeiw ? 12 : 20)))
            ],
          ),
        ));
  }
}
