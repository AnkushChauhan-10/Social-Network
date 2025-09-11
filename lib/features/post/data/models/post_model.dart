import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/post/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.userId,
    required super.content,
    required super.mediaUrl,
    required super.createdAt,
    required super.likesCount,
    required super.commentCount,
  });

  factory PostModel.fromEntity(Post val) => PostModel(
    id: val.id,
    userId: val.userId,
    content: val.content,
    mediaUrl: val.mediaUrl,
    createdAt: val.createdAt,
    likesCount: val.likesCount,
    commentCount: val.commentCount,
  );

  factory PostModel.fromJson(DataMap val) => PostModel(
    id: val["id"],
    userId: val["userId"],
    content: val["content"],
    mediaUrl: val["mediaUrl"],
    createdAt: DateTime.parse(val["createdAt"]).toUtc(),
    likesCount: val["likesCount"],
    commentCount: val["commentCount"],
  );

  PostModel copyWith({String? id, String? mediaUrl}) => PostModel(
    id: id ?? this.id,
    userId: userId,
    content: content,
    mediaUrl: mediaUrl ?? this.mediaUrl,
    createdAt: createdAt,
    likesCount: likesCount,
    commentCount: commentCount,
  );

  DataMap get toJson => {
    "id": id,
    "userId": userId,
    "content": content,
    "mediaUrl": mediaUrl,
    "createdAt": createdAt.toString(),
    "likesCount": likesCount,
    "commentCount": commentCount,
  };
}
