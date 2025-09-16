import 'package:equatable/equatable.dart';
import 'package:social_network/features/post/domain/entities/post.dart';

class PostDetail extends Equatable {
  const PostDetail({
    required this.post,
    required this.userName,
    required this.userProfileUrl,
    required this.isLike,
  });

  final Post post;
  final String userName;
  final String userProfileUrl;
  final bool isLike;

  @override
  List<Object?> get props => [post, isLike, userName, userProfileUrl];
}
