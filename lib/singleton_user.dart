import 'boundaries/object_boundary.dart';
import 'boundaries/user_boundary.dart';

class SingletonUser {
  String? email;
  String? username;
  String? role;
  String? avatar;

  static SingletonUser? _instance;

  SingletonUser._internal();

  static SingletonUser get instance {
    _instance ??= SingletonUser._internal();
    return _instance!;
  }

  @override
  String toString() {
    return 'SingletonUser{email: $email, username: $username, role: $role, avatar: $avatar}';
  }

  CreatedBy get createdBy => CreatedBy(
        userId: UserId(
          email: email.toString(),
          superapp: '2023b.LiorAriely',
        ),
      );
}
