class SingletonDemoObject {
  String? uuid;

  static SingletonDemoObject? _instance;

  SingletonDemoObject._internal();

  static SingletonDemoObject get instance {
    _instance ??= SingletonDemoObject._internal();
    return _instance!;
  }

  @override
  String toString() {
    return 'SingletonUser{uuid: $uuid}';
  }
}
