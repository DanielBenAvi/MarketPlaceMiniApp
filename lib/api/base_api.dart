import '../singleton_user.dart';

class BaseApi {
  final host = "localhost";
  final portNumber = "8084";
  SingletonUser user = SingletonUser.instance;
  final String superApp = "2023b.LiorAriely";
  final String demoObjectInternalObjectId =
      "b8c3453e-ef62-4476-99bf-a22d9e75bb05"; // TODO: change to your object id when start the app
}
