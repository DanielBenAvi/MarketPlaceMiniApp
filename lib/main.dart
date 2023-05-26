import 'package:flutter/material.dart';
import 'package:marketplace/screens/screen_login.dart';

void main() async {
  runApp(
    MaterialApp(
      title: 'Social Hive',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const ScreenLogin(),
      },
    ),
  );
}
