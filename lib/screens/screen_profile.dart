// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:marketplace/api/command_api.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/boundaries/object_boundary.dart';
import 'package:marketplace/singleton_user.dart';
import 'package:marketplace/widgets/avatar_item.dart';
import 'package:image_network/image_network.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final SingletonUser singletonUser = SingletonUser.instance;
  late ObjectBoundary userDetails = ObjectBoundary.empty();

  @override
  void initState() {
    debugPrint('\n -- initState -- ProfileScreen');
    super.initState();
    debugPrint('singletonUser: ${singletonUser.toString()}');
    updateRole();
    _getUserDetails();
  }

  Future updateRole() async {
    await UserApi().updateRole('MINIAPP_USER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.network(
                  singletonUser.avatar ?? 'https://picsum.photos/300/300',
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 20),
              Text('Email: ${singletonUser.email}',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text('UserName: ${singletonUser.username}'),
              const SizedBox(height: 20),
              Text('Name: ${userDetails.objectDetails['name']}'),
              const SizedBox(height: 20),
              Text('Phone number: ${userDetails.objectDetails['phoneNum']}'),
              const SizedBox(height: 20),
              Text('Preferences: ${userDetails.objectDetails['preferences']}'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getUserDetails() async {
    await CommandApi().getUserDetails().then((value) {
      setState(() {
        userDetails = value!;
      });
    });
  }
}
