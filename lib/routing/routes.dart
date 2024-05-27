import 'package:flutter/material.dart';
import 'package:instagram_demo/views/home_page.dart';
import 'package:instagram_demo/views/login_page.dart';

final Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (context) => const LoginPage(),
  HomePage.routeName:(context) => const HomePage()
};