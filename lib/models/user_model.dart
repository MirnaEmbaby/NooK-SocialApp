class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    bio = json['bio'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'bio': bio,
      'uId': uId,
      'image': image,
      'cover': cover,
      'isEmailVerified': isEmailVerified,
    };
  }
}
