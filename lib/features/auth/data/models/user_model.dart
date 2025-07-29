import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.email, required super.name});

  /// Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? "",
      email: json['email'] ?? "",
      name: json['name'] ?? "",
    );
  }

  /// Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }

  UserModel copyWith({String? id, String? email, String? name}) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
