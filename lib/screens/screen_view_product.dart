import 'package:flutter/material.dart';
import 'package:marketplace/api/object_api.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/boundaries/object_boundary.dart';
import 'package:marketplace/singleton_user.dart';

class ScreenProductDetails extends StatelessWidget {
  const ScreenProductDetails({super.key, required this.objectBoundary});
  final ObjectBoundary objectBoundary;

  @override
  Widget build(BuildContext context) {
    SingletonUser user = SingletonUser.instance;
    String objectId = objectBoundary.objectId.internalObjectId;

    return Scaffold(
      appBar: AppBar(
        title: Text(objectBoundary.objectDetails['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Image.network(
                  objectBoundary.objectDetails['image'],
                  width: 300,
                  height: 300,
                ),
                const SizedBox(height: 20),
                Text(
                  objectBoundary.objectDetails['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  objectBoundary.objectDetails['description'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Price: ${objectBoundary.objectDetails['price']}\$',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Contact: ${objectBoundary.objectDetails['contact']}',
                ),
                const SizedBox(height: 20),
                Text(
                  'Categories:\n${objectBoundary.objectDetails['preferences'].toString().substring(1, objectBoundary.objectDetails['preferences'].toString().length - 1).replaceAll('"', '')}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                objectBoundary.createdBy.userId.email.toString() == user.email.toString() ? OutlinedButton(
                  onPressed: () {
                    _soled(objectId);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Sold'),
                ): Container(),
            ],
          ),
        ),
      ),
    );
  }
  
  Future _soled(String objectId) async{
    await UserApi().updateRole("SUPERAPP_USER");
    await ObjectApi().productSold(objectId);
  }

}
