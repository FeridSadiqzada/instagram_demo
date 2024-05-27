// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_demo/views/home_page.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingRegister = false.obs;

  var token = ''.obs;

  void updateToken(String newToken) {
    token.value = newToken;
  }

  String getToken() {
    return token.value;
  }

  Future<void> login(String username, String password) async {
    isLoading(true);
    String requestBody = jsonEncode({
      'login': username.toString(),
      'password': password.toString(),
    });
    try {
      var response = await http.post(
        Uri.parse('https://instagram.bakudevs.com/api/customer/v1/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: requestBody,
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (kDebugMode) {
        print(requestBody);
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body);
        String accessToken = decodedJson['access_token'];
        updateToken(accessToken);
        Get.offAll(
          () =>  HomePage(),
          transition: Transition.rightToLeft,
          );
      } else {
        Get.snackbar(
          'Hata',
          'E-mail ya da şifrə yanlışdır!!!',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> register(String email, String phone, String username,
      String password, String passwordConfirmation) async {
    isLoadingRegister(true);
    String requestBody = jsonEncode({
      'email': username.toString(),
      'phone': phone.toString(),
      'username': username.toString(),
      'password': password.toString(),
      'password_confirmation': passwordConfirmation.toString(),
    });
    try {
      var uri =
          Uri.parse('https://instagram.bakudevs.com/api/customer/v1/register');
      var request = http.MultipartRequest('POST', uri)
        ..fields['email'] = email.toString()
        ..fields['phone'] = phone.toString()
        ..fields['username'] = username.toString()
        ..fields['password'] = password.toString()
        ..fields['password_confirmation'] = passwordConfirmation.toString();

      request.headers.addAll({
        'User-Agent': 'PostmanRuntime/7.37.3',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      var response = await request.send();
      String res = await response.stream.bytesToString();
      if (kDebugMode) {
        print(requestBody);
      }
      if (kDebugMode) {
        print(res);
      }

      if (response.statusCode == 200) {
        Get.offAll(() =>  HomePage(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 600));
      } else {
        Get.snackbar(
          'Error',
          'Bütün inputlar dolmalıdır!',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      isLoadingRegister(false);
    }
  }
}
