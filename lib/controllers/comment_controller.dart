
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_demo/models/comment.dart';
import 'dart:convert';


class CommentController extends GetxController {
  var comment = <Comments>[].obs;
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2luc3RhZ3JhbS5iYWt1ZGV2cy5jb20vYXBpL2N1c3RvbWVyL3YxL3JlZ2lzdGVyIiwiaWF0IjoxNjk2NTA3NDM2LCJuYmYiOjE2OTY1MDc0MzYsImp0aSI6Ik9RQmd5b1dwMVRUR1dRS2ciLCJzdWIiOiIxIiwicHJ2IjoiMWQwYTAyMGFjZjVjNGI2YzQ5Nzk4OWRmMWFiZjBmYmQ0ZThjOGQ2MyJ9.ooL3OdoN0o2jf-LgozZXa8wYWKRY1kJDGIWgR5scz_Q'; //'authController.getToken()';

 
  void fetchComments(int id) async {
    ///comment.clear();
   // AuthController authController = Get.find<AuthController>();
    //'authController.getToken()'; dinamik şəkildə də göndərə bilmək üçün
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse('https://instagram.bakudevs.com/api/customer/v1/posts/comments/${id}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      for (var item in jsonData['data']) {
        comment.add(Comments.fromJson(item));
      }
      if (kDebugMode) {
        print(comment.length);
      }
      if (kDebugMode) {
        print("COMMENTLIST");
        print(comment);
      }
      if (kDebugMode) {
        print(jsonData);
      }
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}
