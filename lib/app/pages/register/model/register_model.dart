import 'dart:convert';

class UserResponse {
  UserResponse({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.authToken,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? authToken;

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        authToken: json["auth_token"] == null ? null : json["auth_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "auth_token": authToken == null ? null : authToken,
      };
}

class UserResquest {
  UserResquest({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  });

  String? email;
  String? firstName;
  String? lastName;
  String? password;

  factory UserResquest.fromRawJson(String str) =>
      UserResquest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResquest.fromJson(Map<String, dynamic> json) => UserResquest(
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "password": password == null ? null : password,
      };
}
