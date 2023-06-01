import 'dart:convert';

import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http/retry.dart';

import '../boundaries/object_boundary.dart';
import '../boundaries/user_boundary.dart';
import 'base_api.dart';

/// UserApi class
class UserApi extends BaseApi {
  /// create User method
  Future<bool?> postUser(Map<String, dynamic> newUserBoundary) async {
    // create user
    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newUserBoundary),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create user');
    }

    return true;
  }

  Future<ObjectBoundary?> postUserDetails(
      String name, String phoneNum, List<String> preferences) async {
    Map<String, dynamic> userDetails = {
      "objectId": {},
      "type": "USER_DETAILS",
      "alias": "USER_DETAILS",
      "active": true,
      "location": {"lat": 10.200, "lng": 10.200},
      "createdBy": {
        "userId": {"superapp": superApp, "email": singletonUser.email}
      },
      "objectDetails": {
        "name": name,
        "phoneNum": phoneNum,
        "preferences": preferences.toList()
      }
    };

    http.Response response;
    try {
      response = await http.post(
        Uri.parse('http://$host:$portNumber/superapp/objects'
            '?userSuperapp=$superApp&userEmail=${singletonUser.email}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(userDetails),
      );
    } catch (e) {
      debugPrint('[LOG] --- Failed to create user details');
      throw Exception('Failed to create user details');
    }

    if (response.statusCode != 200) {
      throw Exception('[LOG] - Failed to create user details');
    }

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    return ObjectBoundary.fromJson(responseBody);
  }

  /// get User method
  Future<UserBoundary> getUser(String userEmail) async {
    final client = RetryClient(http.Client());
    final response = await http.get(Uri.parse(
        'http://$host:$portNumber/superapp/users/login/2023b.LiorAriely/$userEmail'));
    try {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      UserBoundary userBoundary = UserBoundary.fromJson(userMap);
      singletonUser.email = userBoundary.userId.email;
      singletonUser.role = userBoundary.role;
      singletonUser.username = userBoundary.username;
      singletonUser.avatar = userBoundary.avatar;
      return userBoundary;
    } finally {
      client.close();
    }
  }

  Future updateRole(String newRole) async {
    Map<String, dynamic> updateUserBoundary = {
      'role': newRole,
    };

    try {
      http.put(
        Uri.parse(
            'http://$host:$portNumber/superapp/users/2023b.LiorAriely/${singletonUser.email}'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(updateUserBoundary),
      );
      debugPrint('LOG --- user role updated to $newRole');
    } catch (e) {
      debugPrint('LOG --- Failed to update user role');
      throw Exception('Failed to update user role');
    }
  }
}
