import 'package:marketplace/boundaries/user_boundary.dart';

import 'object_boundary.dart';

class CommandBoundary {
  CommandId commandId;
  String command;
  TargetObject targetObject;
  InvokedBy invokedBy;
  DateTime creationTimestamp;
  Map<String, dynamic> commandAttributes;

  CommandBoundary({
    required this.commandId,
    required this.command,
    required this.targetObject,
    required this.invokedBy,
    required this.creationTimestamp,
    required this.commandAttributes,
  });

  // fromJson
  CommandBoundary.fromJson(Map<String, dynamic> json)
      : commandId = CommandId.fromJson(json['commandId']),
        command = json['command'],
        targetObject = TargetObject.fromJson(json['targetObject']),
        creationTimestamp = DateTime.parse(json['creationTimestamp']),
        invokedBy = InvokedBy.fromJson(json['invokedBy']),
        commandAttributes = json['commandAttributes'];

  // toJson
  Map<String, dynamic> toJson() => {
        'commandId': commandId.toJson(),
        'command': command,
        'targetObject': targetObject.toJson(),
        'invokedBy': invokedBy.toJson(),
        'creationTimestamp': creationTimestamp.toIso8601String(),
        'commandAttributes': commandAttributes,
      };
}

class CommandId {
  String superapp;
  String miniapp;
  String internalCommandId;

  CommandId({
    required this.superapp,
    required this.miniapp,
    required this.internalCommandId,
  });

  // fromJson
  CommandId.fromJson(Map<String, dynamic> json)
      : superapp = json['superapp'],
        miniapp = json['miniapp'],
        internalCommandId = json['internalCommandId'];

  // toJson
  Map<String, dynamic> toJson() => {
        'superapp': superapp,
        'miniapp': miniapp,
        'internalCommandId': internalCommandId,
      };
}

class TargetObject {
  ObjectId objectId;

  TargetObject({required this.objectId});

  // fromJson
  TargetObject.fromJson(Map<String, dynamic> json)
      : objectId = ObjectId.fromJson(json['objectId']);

  // toJson
  Map<String, dynamic> toJson() => {
        'objectId': objectId.toJson(),
      };
}

class InvokedBy {
  UserId userId;

  InvokedBy({required this.userId});

  // fromJson
  InvokedBy.fromJson(Map<String, dynamic> json)
      : userId = UserId.fromJson(json['userId']);

  // toJson
  Map<String, dynamic> toJson() => {
        'userId': userId.toJson(),
      };
}
