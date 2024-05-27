// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_demo/routing/routes.dart';
import 'package:instagram_demo/views/home_page.dart';
import 'package:instagram_demo/views/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      initialRoute: LoginPage.routeName,
       getPages: [
      GetPage(name: LoginPage.routeName, page: () => LoginPage()),
      GetPage(name: HomePage.routeName, page: () => HomePage()),
    ],
      routes: routes
      
    );
  }
}
