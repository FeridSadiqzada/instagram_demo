
// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_demo/controllers/comment_controller.dart';
import 'package:instagram_demo/models/comment.dart';
import 'package:instagram_demo/models/user.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentPage> {
  late CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: commentController.comment.isNotEmpty
            ? ListView.builder(
                itemCount: commentController.comment.length,
                itemBuilder: (context, i) {
                  return _comments(
                      commentController.comment[i], commentController.comment[i].user);
                },
              )
            : Center(child: Text("No comments available")),
      ),
    );
  }

  Row _comments(Comments comments, User user) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            user.image ??"https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp"),
          radius: 18,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.username}: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(comments.text),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    comments.timeDiff,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
        Icon(Icons.favorite, size: 16),
      ],
    );
  }
}
