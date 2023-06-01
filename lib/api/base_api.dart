import 'package:marketplace/singleton_demo_object.dart';

import '../singleton_user.dart';

class BaseApi {
  final host = "localhost";
  final portNumber = "8084";
  SingletonUser user = SingletonUser.instance;
  final String superApp = "2023b.LiorAriely";
  SingletonDemoObject demoObject = SingletonDemoObject.instance;
}
