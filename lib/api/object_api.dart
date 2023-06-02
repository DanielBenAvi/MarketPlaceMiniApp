import 'dart:convert';

import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http/retry.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/singleton_demo_object.dart';

import '../boundaries/object_boundary.dart';
import '../singleton_user.dart';
import 'base_api.dart';

class ObjectApi extends BaseApi {
  Future<ObjectBoundary> postObject(ObjectBoundary objectBoundary) async {
    await UserApi().updateRole(
        'SUPERAPP_USER'); // update role to SUPERAPP_USER only SuperApp_user can create objects
    debugPrint('\n -- postObject');
    final response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/objects'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(objectBoundary.toJson()),
    );
    if (response.statusCode == 200) {
      ObjectBoundary objectBoundary =
          ObjectBoundary.fromJson(jsonDecode(response.body));
      debugPrint('objectBoundary: ${objectBoundary.toJson()}');
      return objectBoundary;
    } else {
      throw Exception('Failed to create Object.');
    }
  }

  Future<ObjectBoundary> getObjectBoundary(String internalObjectId) async {
    final client = RetryClient(http.Client());
    final response = await http.get(Uri.parse(
        'http://$host:$portNumber/superapp/objects/2023b.LiorAriely/$internalObjectId'));
    try {
      Map<String, dynamic> object = jsonDecode(response.body);
      return ObjectBoundary.fromJson(object);
    } finally {
      client.close();
    }
  }

  Future postObjectJson(Map<String, dynamic> objectBoundary) async {
    debugPrint('LOG --- POST Event');
    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/objects'
          '?userSuperapp=$superApp&userEmail=${SingletonUser.instance.email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(objectBoundary),
    );

    if (response.statusCode != 200) {
      debugPrint('LOG --- Failed to create event');
      throw Exception(response.body);
    } else {
      debugPrint('LOG --- Success to create event');
    }
  }

  Future getDemoObject() async {
    final client = RetryClient(http.Client());
    try {
      final response = await client.get(Uri.parse(
          'http://$host:$portNumber/superapp/objects/search/byAlias/OBJECT_FOR_COMMAND_WITHOUT_TARGET_OBJECT?userSuperapp=$superApp&userEmail=${SingletonUser.instance.email}'));
      if (response.statusCode != 200) {
        throw Exception(
            '[EXCEPTION] Failed to get demo object, status code: ${response.statusCode}');
      }

      if (jsonDecode(response.body).isEmpty) {
        debugPrint('LOG --- Demo object not found, creating one');
        await UserApi().updateRole(
            'SUPERAPP_USER'); // update role to SUPERAPP_USER only SuperApp_user can create objects
      }

      Map<String, dynamic> object = jsonDecode(response.body).first;
      SingletonDemoObject singletonDemoObject = SingletonDemoObject.instance;
      singletonDemoObject.uuid = object['objectId']['internalObjectId'];
      debugPrint('[LOG] ${SingletonDemoObject.instance}');
    } catch (e) {
      throw Exception('Failed to get demo object: $e');
    } finally {
      client.close();
    }
  }


  Future productSold(String internalObjectId) async{
    Map<String, dynamic> updatedProduct = {
      "active": false,
    };

    try {
      http.put(
        Uri.parse(
              'http://$host:$portNumber/superapp/objects/$superApp/$internalObjectId?userSuperapp=$superApp&userEmail=${singletonUser.email}'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(updatedProduct),
      );
    } catch (e) {
      throw Exception('[LOG] --- faild to make product unactive: $e');
    }
  }
}
