import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_gallery/screens/components/photoCard.dart';
import 'package:photo_gallery/screens/photoDetails.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_downloader/image_downloader.dart';
import 'methods/showToast.dart';
import '../../domain/photoData.dart';
import 'dismissibleSlides.dart';

class PhotoList extends StatefulWidget {
  final bool isSoloViewMode;
  PhotoList({Key key, this.isSoloViewMode}) : super(key: key);

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  List<PhotoData> data = [];
  var photoDetailsData;
  int index;

  @override
  Widget build(BuildContext context) {
    _updateLikesMark(bool like) {
      setState(() => data[index].like = like);
    }

    _likeThroughtPages(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PhotoDetails(
                  data: photoDetailsData,
                )),
      );
      _updateLikesMark(result);
    }

    _downloadImage(String url) async {
      try {
        // Saved with this method.
        var imageId = await ImageDownloader.downloadImage(url);
        if (imageId == null) {
          return;
        }

        // Below is a method of obtaining saved image information.
        var fileName = await ImageDownloader.findName(imageId);
        var path = await ImageDownloader.findPath(imageId);
        var size = await ImageDownloader.findByteSize(imageId);
        var mimeType = await ImageDownloader.findMimeType(imageId);
      } on PlatformException catch (error) {
        print(error);
      }
    }

    return Container(
        child: GridView.builder(
            itemCount: data.length,
            gridDelegate: widget.isSoloViewMode
                ? SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .75)
                : SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: .85),
            itemBuilder: (context, i) {
              return Dismissible(
                key: UniqueKey(),
                child: GestureDetector(
                    child: PhotoCard(
                        data: data[i], typeVeiw: widget.isSoloViewMode),
                    onTap: () {
                      setState(() {
                        photoDetailsData = data[i];
                        index = i;
                      });
                      _likeThroughtPages(context);
                    }),
                onDismissed: (direction) {
                  setState(() {
                    if (direction == DismissDirection.endToStart) {
                      data.removeAt(i);
                    } else {
                      _downloadImage(data[i].urlFull);
                    }
                  });
                },
                background: slideLeftBackground(),
                secondaryBackground: slideRightBackground(),
              );
            }));
  }

  _loadPhoto() async {
    final response = await http.get(
        'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');
    if (response.statusCode == 200) {
      ///print(response.body);
      var allData = (json.decode(response.body) as List);
      var photolist = List<PhotoData>();
      allData.forEach((element) {
        var record = PhotoData(
            id: element['id'],
            name: element['alt_description'],
            urlSmall: element['urls']['small'],
            urlFull: element['urls']['full'],
            author: element['user']['username'],
            like: false);

        photolist.add(record);
      });
      setState(() {
        data = photolist;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPhoto();
    WidgetsBinding.instance.addPostFrameCallback((_) => showToast(
        'Swipe to right for delete!\nSwipe to left for download!', context,
        gravity: Toast.BOTTOM, duration: 3));
  }
}
