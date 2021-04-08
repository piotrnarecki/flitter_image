class ImageModel {

  String title;
  String url;

  ImageModel(this.title, this.url);


  ImageModel.fromJSON(Map<String,dynamic>jsonData){
    this.title=jsonData["title"];
    final String mediaUrl = jsonData["media"]["m"];
    this.url=mediaUrl.replaceFirst("_m.jpg", ".jpg");
  }

}
