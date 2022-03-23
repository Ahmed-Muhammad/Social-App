class CreatePostModel {
  String? name;
  String? image;
  String? uid;
  String? dateTime;
  String? text;
  String? postImage;

  CreatePostModel({
    this.name,
    this.image,
    this.uid,
    this.dateTime,
    this.text,
    this.postImage,
  });

  CreatePostModel.fromJson(Map<String, dynamic>? json) {
    name = json!["name"];
    image = json["image"];
    uid = json["uid"];
    dateTime = json["dateTime"];
    text = json["text"];
    postImage = json["postImage"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'uid': uid,
      'postImage': postImage,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
