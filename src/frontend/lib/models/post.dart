import 'package:frontend/utils/constants.dart';

import './user.dart';

class QuotedPost {
  final int id;
  final User author;
  final String body;
  final String createdAt;
  final String? editedAt;
  QuotedPost(
      {required this.id,
      required this.author,
      required this.body,
      required this.createdAt,
      required this.editedAt});

  factory QuotedPost.fromMap(ApiObject data) {
    return QuotedPost(
        id: data['id'],
        author: User.fromMap(data['author']),
        body: data['body'],
        createdAt: data['created_at'],
        editedAt: data['edited_at']);
  }
}

class Post {
  final int id;
  final User author;
  final String? body;
  final QuotedPost? quoting;
  int likeCount;
  bool isLiked;
  final Post? rePost;
  int rePostCount;
  final String createdAt;
  final String? editedAt;
  Post({
    required this.id,
    required this.body,
    required this.author,
    required this.quoting,
    required this.rePost,
    required this.rePostCount,
    required this.createdAt,
    required this.editedAt,
    required this.likeCount,
    required this.isLiked,
  });

  factory Post.fromMap(ApiObject data) {
    return Post(
        id: data['id'],
        body: data['body'],
        author: User.fromMap(data['author']),
        quoting: data['quoting'] != null
            ? QuotedPost.fromMap(data['quoting'])
            : null,
        rePost: data['re_post'] != null ? Post.fromMap(data['re_post']) : null,
        rePostCount: data['re_post_count'],
        createdAt: data['created_at'],
        editedAt: data['edited_at'],
        likeCount: data['like_count'],
        isLiked: data['is_liked']);
  }
}
