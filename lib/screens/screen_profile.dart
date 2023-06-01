import 'package:flutter/material.dart';
import 'package:marketplace/api/command_api.dart';
import 'package:marketplace/api/user_api.dart';
import 'package:marketplace/boundaries/object_boundary.dart';
import 'package:marketplace/singleton_user.dart';
import 'package:marketplace/widgets/avatar_item.dart';

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
    updateRole();
    _getUserDetails();
  }

  Future updateRole() async {
    await UserApi().updateRole('MINIAPP_USER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AvatarItem(
                photoUrl: singletonUser.avatar?.toString() ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw4dcOs0ebrWK3g4phCh7cfF-aOM3rhxnsCQ&usqp=CAU',
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
