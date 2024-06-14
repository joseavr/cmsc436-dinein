import 'package:group_project/backend/core/entities/user/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.avatarUrl,
  });

  // TODO add more fields as the app grows
  // It's ok to have nulls set to keys,
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['full_name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      phone: json['phone'],
    );
  }
}
