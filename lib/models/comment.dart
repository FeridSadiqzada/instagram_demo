import 'package:instagram_demo/models/user.dart';

class Comments {
  final int id;
  final String text;
  final User user;
  final String timeDiff;

  Comments({
    required this.id,
    required this.text,
    required this.user,
    required this.timeDiff,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'],
      text: json['text'],
      user: User.fromJson(json['user']),
      timeDiff: json['timeDiff'],
    );
  }
}
