
import 'package:marketplace/boundaries/user_boundary.dart';

class ObjectBoundary {
  ObjectId objectId;
  String type;
  String alias;
  bool active;
  DateTime creationTimestamp;
  LocationBoundary location;
  CreatedBy createdBy;
  Map<String, dynamic> objectDetails;

  // empty constructor
  ObjectBoundary.empty()
      : objectId = ObjectId(superapp: '', internalObjectId: ''),
        type = '',
        alias = '',
        active = false,
        creationTimestamp = DateTime.now(),
        location = LocationBoundary(lat: 0.0, lng: 0.0),
        createdBy = CreatedBy(userId: UserId(superapp: '', email: '')),
        objectDetails = {};

  // constructor
  ObjectBoundary({
    required this.objectId,
    required this.type,
    required this.alias,
    required this.active,
    required this.creationTimestamp,
    required this.location,
    required this.createdBy,
    required this.objectDetails,
  });

  // fromJson
  ObjectBoundary.fromJson(Map<String, dynamic> json)
      : objectId = ObjectId.fromJson(json['objectId']),
        type = json['type'],
        alias = json['alias'],
        active = json['active'],
        creationTimestamp = DateTime.parse(json['creationTimestamp']),
        location = LocationBoundary.fromJson(json['location']),
        createdBy = CreatedBy.fromJson(json['createdBy']),
        objectDetails = json['objectDetails'];

  // toJson
  Map<String, dynamic> toJson() => {
        'objectId': objectId.toJson(),
        'type': type,
        'alias': alias,
        'active': active,
        'creationTimestamp': creationTimestamp.toIso8601String(),
        'location': location.toJson(),
        'createdBy': createdBy.toJson(),
        'objectDetails': objectDetails,
      };
}

class ObjectId {
  String superapp;
  String internalObjectId;

  ObjectId({required this.superapp, required this.internalObjectId});

  @override
  String toString() {
    return 'ObjectId{superapp: $superapp, internalObjectId: $internalObjectId}';
  }

  ObjectId.fromJson(Map<String, dynamic> json)
      : superapp = json['superapp'],
        internalObjectId = json['internalObjectId'];

  Map<String, dynamic> toJson() => {
        'superapp': superapp,
        'internalObjectId': internalObjectId,
      };
}

class LocationBoundary {
  double lat;
  double lng;

  LocationBoundary({required this.lat, required this.lng});

  // fromJson
  LocationBoundary.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];

  // toJson
  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  @override
  String toString() {
    return 'Location{lat: $lat, lng: $lng}';
  }
}

class CreatedBy {
  UserId userId;

  CreatedBy({required this.userId});

  // fromJson
  CreatedBy.fromJson(Map<String, dynamic> json)
      : userId = UserId.fromJson(json['userId']);

  // toJson
  Map<String, dynamic> toJson() => {
        'userId': userId.toJson(),
      };
}
