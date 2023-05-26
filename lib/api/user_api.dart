import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../boundaries/object_boundary.dart';
import '../boundaries/user_boundary.dart';
import 'base_api.dart';

/// UserApi class
class UserApi extends BaseApi {
  /// create User method
  Future<UserBoundary?> postUser(Map<String, dynamic> newUserBoundary) async {
    // create user
    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newUserBoundary),
    );

    if (response.statusCode != 200) {
      debugPrint('LOG --- Failed to load events');
      return null;
    }

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    return UserBoundary.fromJson(responseBody);
  }

  Future<ObjectBoundary?> postUserDetails(
      String name, String phoneNum, List<String> preferences) async {
    Map<String, dynamic> userDetails = {
      "objectId": {},
      "type": "USER_DETAILS",
      "alias": "userDetails",
      "active": true,
      "location": {"lat": 10.200, "lng": 10.200},
      "createdBy": {
        "userId": {"superapp": superApp, "email": user.email}
      },
      "objectDetails": {
        "name": name,
        "phoneNum": phoneNum,
        "preferences": preferences
      }
    };

    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/objects'
          '?userSuperapp=$superApp&userEmail=${user.email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userDetails),
    );

    if (response.statusCode != 200) {
      debugPrint('LOG --- Failed to create user details');
      return null;
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
      return UserBoundary.fromJson(userMap);
    } finally {
      client.close();
    }
  }

  Future updateRole(String newRole) async {
    Map<String, dynamic> updateUserBoundary = {
      'role': newRole,
    };

    final response = http.put(
      Uri.parse(
          'http://$host:$portNumber/superapp/users/2023b.LiorAriely/${user.email}'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(updateUserBoundary),
    );

    debugPrint('LOG --- response: ${response.toString()}');
  }
}
