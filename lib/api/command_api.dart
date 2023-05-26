import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:marketplace/api/user_api.dart';


import '../boundaries/object_boundary.dart';
import 'base_api.dart';

class CommandApi extends BaseApi {
  Future<List<ObjectBoundary>> getMyEvents() async {
    UserApi().updateRole('MINIAPP_USER');
    // Create command
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "GET_MY_EVENTS",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObjectInternalObjectId
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": user.email}
      },
      "commandAttributes": {}
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
      debugPrint('LOG --- Failed to load events');
      return [];
      // throw Exception('Failed to load events');
    }

    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> events = [];
    for (Map<String, dynamic> object in objects) {
      events.add(ObjectBoundary.fromJson(object));
    }

    return events;
  }

  /// todo: change base on the preferences
  Future<List<ObjectBoundary>> getAllEvent() async {
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "GET_ALL_FUTURE_EVENTS",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObjectInternalObjectId
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": "demo@gmail.com"}
      },
      "commandAttributes": {}
    };

    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/EVENT'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );

    if (response.statusCode != 200) {
      debugPrint('LOG --- Failed to load events');
      return [];
      // throw Exception('Failed to load events');
    }

    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> events = [];
    for (Map<String, dynamic> object in objects) {
      events.add(ObjectBoundary.fromJson(object));
    }

    return events;
  }

  Future<List<ObjectBoundary>> getCreatedByMeEvents() async {
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "GET_EVENTS_CREATED_BY_ME",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObjectInternalObjectId
        }
      },
      "invokedBy": {
        "userId": {"superapp": superApp, "email": user.email}
      },
      "commandAttributes": {}
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
      debugPrint('LOG --- Failed to load events');
      return [];
      // throw Exception('Failed to load events');
    }

    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> events = [];
    for (Map<String, dynamic> object in objects) {
      events.add(ObjectBoundary.fromJson(object));
    }

    return events;
  }

  Future joinEvent(String objectId) async {
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "JOIN_EVENT",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": objectId
        }
      },
      "invokedBy": {
        "userId": {"superapp": superApp, "email": user.email}
      },
      "commandAttributes": {}
    };

    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/EVENT'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );

    if (response.statusCode != 200) {
      debugPrint('LOG --- Failed to add user to event');
    }
  }

  Future leaveEvent(String objectId) async {
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "LEAVE_EVENT",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": objectId
        }
      },
      "invokedBy": {
        "userId": {"superapp": superApp, "email": user.email}
      },
      "commandAttributes": {}
    };

    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/EVENT'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );

    if (response.statusCode != 200) {
      debugPrint('LOG --- Failed to leave event');
    }
  }

  Future<ObjectBoundary?> getUserDetails() async {
    // todo : update role in screen profile

    String createdBy = "2023b.LiorAriely_${user.email}";

    Map<String, dynamic> command = {
      "commandId": {},
      "command": "GET_USER_DETAILS_BY_EMAIL",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObjectInternalObjectId
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": "demo@gmail.com"}
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
      debugPrint('LOG --- Failed to load events');
      return null;
    }

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    debugPrint(
        '\nLOG --- getUserDetails response: ${responseBody.values.first}\n');

    return ObjectBoundary.fromJson(responseBody.values.first);
  }
}
