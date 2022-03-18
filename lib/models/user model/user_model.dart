class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  bool? isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!["email"];
    name = json["name"];
    phone = json["phone"];
    uid = json["uid"];
    isEmailVerified = json["isEmailVerified"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uid': uid,
      'email': email,
      'isEmailVerified' : isEmailVerified
    };
  }
}
