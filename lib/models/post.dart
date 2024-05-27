import 'package:instagram_demo/models/media.dart';
import 'package:instagram_demo/models/user.dart';

class Post {
  final int id;
  final String description;
  final int likes;
  final int comments;
  final bool liked;
  final User user;
  final List<Media> media;

  Post({
    required this.id,
    required this.description,
    required this.likes,
    required this.comments,
    required this.liked,
    required this.user,
    required this.media,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        description: json['description'],
        likes: json['likes'],
        comments: json['comments'],
        liked: json['liked'],
        user: User.fromJson(json['user']),
        media: List<Media>.from(json['media'].map((x) => Media.fromJson(x))),
      );
}