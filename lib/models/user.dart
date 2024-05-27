class User {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String? image;
  final int followerCount;
  final int followCount;
  final int postCount;
  final String? thumbnailImage;
  final bool followed;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    this.image,
    required this.followerCount,
    required this.followCount,
    required this.postCount,
    this.thumbnailImage,
    required this.followed,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        followerCount: json['follower_count'],
        followCount: json['follow_count'],
        postCount: json['post_count'],
        thumbnailImage: json['thumbnail_image'],
        followed: json['followed'],
      );
}