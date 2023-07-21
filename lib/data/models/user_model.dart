import 'dart:convert';

class UserModel {
  final String name;
  final String? email;
  final String pass;

  UserModel({
    required this.name,
    this.email,
    required this.pass,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? pass,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      pass: pass ?? this.pass,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': name,
      'email': email,
      'password': pass,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'],
      pass: map['pass'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(name: $name, email: $email, pass: $pass)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.pass == pass;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ pass.hashCode;
}
