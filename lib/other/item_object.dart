class ItemObject {
  final int id;
  final String name;

  ItemObject({
    required this.id,
    required this.name,
  });

  // fromJson
  ItemObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  // toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
