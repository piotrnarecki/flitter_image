import 'package:flutter/material.dart';
import './image_model.dart';
import './image_list.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  List<ImageModel> images = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flitter Images",
        home: Scaffold(
          appBar: AppBar(title: Text("Flitter Images")),
          body: ImageList(),
        ));
  }
}
