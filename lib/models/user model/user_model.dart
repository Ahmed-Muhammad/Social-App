class UserModel {
  String? name;
  String? email;
  String? phone;
  String? bio;
  String? image;
  String? cover;
  String? uid;
  bool? isEmailVerified;

  UserModel({
    required this.name,
    required this.bio,
    required this.image,
    required this.cover,
    required this.email,
    required this.phone,
    required this.uid,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!["email"];
    name = json["name"];
    cover = json["cover"];
    bio = json["bio"];
    image = json["image"];
    phone = json["phone"];
    uid = json["uid"];
    isEmailVerified = json["isEmailVerified"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cover': cover,
      'phone': phone,
      'bio': bio,
      'image': image,
      'uid': uid,
      'email': email,
      'isEmailVerified' : isEmailVerified
    };
  }
}
