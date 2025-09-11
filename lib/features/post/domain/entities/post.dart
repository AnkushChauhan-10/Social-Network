import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.mediaUrl,
    required this.createdAt,
    required this.likesCount,
    required this.commentCount,
  });

  final String id;
  final String userId;
  final String content;
  final String mediaUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentCount;

  factory Post.create({
    required String userId,
    required String content,
    required DateTime createdAt,
  }) => Post(
    id: "",
    userId: userId,
    content: content,
    mediaUrl: "",
    createdAt: createdAt,
    likesCount: 0,
    commentCount: 0,
  );

  @override
  List<Object?> get props => [id];
}
