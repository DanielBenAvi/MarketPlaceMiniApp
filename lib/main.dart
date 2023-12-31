// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:marketplace/screens/screen_search_product.dart';
import 'firebase_options.dart';

import 'package:marketplace/screens/screen_add_product.dart';
import 'package:marketplace/screens/screen_explore_products.dart';
import 'package:marketplace/screens/screen_login.dart';
import 'package:marketplace/screens/screen_my_products.dart';
import 'package:marketplace/screens/screen_profile.dart';
import 'package:marketplace/screens/screen_register.dart';
import 'package:marketplace/screens/screen_register_user_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      title: 'Marketplace',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      routes: {
        '/login': (context) => const ScreenLogin(),
        '/register': (context) => const ScreenRegister(),
        '/register_user_details': (context) =>
            const ScreenRegisterUserDetails(),
        '/explore_products': (context) => const ScreenExploreProducts(),
        '/my_products': (context) => const ScreenMyProducts(),
        '/my_profile': (context) => const ScreenProfile(),
        '/add_product': (context) => const ScreenAddProduct(),
        '/search_products': (context) => const ScreenSearchProducts(),
      },
    ),
  );
}
