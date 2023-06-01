import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:marketplace/boundaries/object_boundary.dart';

import 'base_api.dart';

class CommandApi extends BaseApi {
  Future<ObjectBoundary?> getUserDetails() async {
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "GET_USER_DETAILS_BY_EMAIL",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObject.uuid
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": singletonUser.email}
      },
    };

    // Post command
    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/EVENT'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get user details');
    }

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody.values.first == null) {
      throw Exception('Failed to get user details');
    }
    debugPrint(
        '\nLOG --- getUserDetails response: ${responseBody.values.first}\n');

    return ObjectBoundary.fromJson(responseBody.values.first);
  }
}
