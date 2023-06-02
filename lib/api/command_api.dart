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
      Uri.parse('http://$host:$portNumber/superapp/miniapp/MARKETPLACE'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );

    if (response.statusCode != 200) {
      debugPrint('[LOG] --- command user details --- code:${response.statusCode}' );
      return null;
    }

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody.values.first == null) {
      throw Exception('Failed to get user details');
    }

    return ObjectBoundary.fromJson(responseBody.values.first);
  }

  Future<List<ObjectBoundary>> getProductsByPrefrences() async{
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "GET_PRODUCTS_BY_PREFERENCES",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObject.uuid
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": singletonUser.email}
      },
      "commandAttributes":{}
    };

    // Post command
    http.Response response;
    try {
      response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/MARKETPLACE'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );
    } catch (e) {
      throw Exception('Failed to get products by prefrences 1');
    }

    if(response.statusCode != 200){
      debugPrint('[LOG] --- command get prefrences --- code ${response.statusCode}' );
      return [];
    }


    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> products = [];
    for (Map<String, dynamic> object in objects) {
      products.add(ObjectBoundary.fromJson(object));
    }

    return products;
    
  }

  Future<List<ObjectBoundary>> getMyProducts() async{
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "GET_ALL_MY_PRODUCTS",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObject.uuid
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": singletonUser.email}
      },
      "commandAttributes":{}
    };

    // Post command
    http.Response response;
    try {
      response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/MARKETPLACE'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );
    } catch (e) {
      throw Exception(e);
    }

    if(response.statusCode != 200){
      debugPrint('[LOG] --- command my products --- code${response.statusCode}' );
      return [];
    }


    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> products = [];
    for (Map<String, dynamic> object in objects) {
      products.add(ObjectBoundary.fromJson(object));
    }

    return products;
    
  }

  Future<List<ObjectBoundary>> searchProductsByName(String name) async{
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "SEARCH_PRODUCT_BY_NAME",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObject.uuid
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": singletonUser.email}
      },
      "commandAttributes":{
        "name": name
      }
    };

    // Post command
    http.Response response;
    try {
      response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/MARKETPLACE'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );
    } catch (e) {
      throw Exception(e);
    }

    if(response.statusCode != 200){
      debugPrint('[LOG] --- command my products --- code${response.statusCode}' );
      return [];
    }


    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> products = [];
    for (Map<String, dynamic> object in objects) {
      products.add(ObjectBoundary.fromJson(object));
    }

    return products;
    
  }

  Future<List<ObjectBoundary>> searchProductsByPrice(double minPrice, double maxPrice) async{
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "SEARCH_PRODUCT_BY_PRICE",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObject.uuid
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": singletonUser.email}
      },
      "commandAttributes":{
        "minPrice": minPrice,
        "maxPrice": maxPrice
      }
    };

    // Post command
    http.Response response;
    try {
      response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/MARKETPLACE'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );
    } catch (e) {
      throw Exception(e);
    }

    if(response.statusCode != 200){
      debugPrint('[LOG] --- command my products --- code${response.statusCode}' );
      return [];
    }


    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> products = [];
    for (Map<String, dynamic> object in objects) {
      products.add(ObjectBoundary.fromJson(object));
    }

    return products;
    
  }

  Future<List<ObjectBoundary>> searchProductsByPreferences(List<String> prefrences) async{
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "SEARCH_PRODUCT_BY_PREFERENCES",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": demoObject.uuid
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": singletonUser.email}
      },
      "commandAttributes":{
        "preferences": prefrences
      }
    };

    // Post command
    http.Response response;
    try {
      response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/MARKETPLACE'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );
    } catch (e) {
      throw Exception(e);
    }

    if(response.statusCode != 200){
      debugPrint('[LOG] --- command my products --- code${response.statusCode}' );
      return [];
    }


    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> products = [];
    for (Map<String, dynamic> object in objects) {
      products.add(ObjectBoundary.fromJson(object));
    }

    return products;
    
  }

}
