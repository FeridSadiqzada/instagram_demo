// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_demo/controllers/comment_controller.dart';
import 'package:instagram_demo/models/comment.dart';
import 'package:instagram_demo/models/user.dart';

class CommentPage extends StatefulWidget {
  final int postId;

  const CommentPage({super.key, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late CommentController commentController;

  @override
  void initState() {
    super.initState();
    commentController = Get.find<CommentController>();
    // Belirli postId için yorumları yükleyin
    commentController.fetchComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        var comments = commentController.commentsMap[widget.postId] ?? [];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: comments.isNotEmpty
              ? ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, i) {
                    return _comments(comments[i], comments[i].user);
                  },
                )
              : Center(child: Text("No comments available")),
        );
      }),
    );
  }

  Row _comments(Comments comment, User user) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            user.image ?? "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp",
          ),
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
                Text(comment.text),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    comment.timeDiff,
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
