import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'image_model.dart';

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  List<ImageModel> images = [];

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return images.length == 0 ? loadingIndicator() : imageList();

  }

  Future<void> getImages() async {
    var response = await get(Uri.parse(
        "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"));
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final imagesJson = map["items"];
      images = [];
      imagesJson.forEach((image) {
        final imageM = ImageModel.fromJSON(image);
        //images = [];
        setState(() {
          images.add(imageM);
        });
      });
    }
  }

  Widget loadingIndicator() {
    getImages();
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget imageList() {
    return RefreshIndicator(
      child: ListView.builder(
          itemCount: images.length,
          itemBuilder: (contex, index) {
            final imageData = images[index];

            return Column(children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  child: Image.network(imageData.url)),
              Container(padding: EdgeInsets.only(bottom: 10.0)),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    imageData.title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ))
            ]);
          }),
      onRefresh: getImages,
    );
  }
}
