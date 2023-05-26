class NewUserBoundary {
  // constructor
  String email;
  String role;
  String username;
  String avatar;

  NewUserBoundary({
    required this.email,
    required this.role,
    required this.username,
    required this.avatar,
  });

  // fromJson
  NewUserBoundary.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        role = json['role'],
        username = json['username'],
        avatar = json['avatar'];

  // toJson
  Map<String, dynamic> toJson() => {
        'email': email,
        'role': role,
        'username': username,
        'avatar': avatar,
      };
}

class UserBoundary {
  UserId userId;
  String role;
  String username;
  String avatar;

  UserBoundary({
    required this.userId,
    required this.role,
    required this.username,
    required this.avatar,
  });

  // fromJson
  UserBoundary.fromJson(Map<String, dynamic> json)
      : userId = UserId.fromJson(json['userId']),
        role = json['role'],
        username = json['username'],
        avatar = json['avatar'];

  // toJson
  Map<String, dynamic> toJson() => {
        'userId': userId.toJson(),
        'role': role,
        'username': username,
        'avatar': avatar,
      };
}

class UserId {
  String superapp;
  String email;

  UserId({required this.superapp, required this.email});

  // fromJson
  UserId.fromJson(Map<String, dynamic> json)
      : superapp = json['superapp'],
        email = json['email'];

  // toJson
  Map<String, dynamic> toJson() => {
        'superapp': superapp,
        'email': email,
      };
}
