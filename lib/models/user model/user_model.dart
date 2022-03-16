class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    uid = json["uid"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uid': uid,
      'email': email,
    };
  }
}
