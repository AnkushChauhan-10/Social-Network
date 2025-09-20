import 'package:equatable/equatable.dart';
import 'package:social_network/features/post/domain/entities/post_detail.dart';

sealed class PostState extends Equatable {
  const PostState();
}

final class PostInitial extends PostState {
  const PostInitial();

  @override
  List<Object?> get props => [];
}

final class PostLoading extends PostState {
  const PostLoading();

  @override
  List<Object?> get props => [];
}

final class PostSuccess extends PostState {
  const PostSuccess(this.postDetail, this.isLike, this.isSave, this.likeCount);

  final PostDetail postDetail;
  final bool isLike;
  final bool isSave;
  final int likeCount;

  @override
  List<Object?> get props => [
    postDetail.post.id,
    postDetail.post.likesCount,
    postDetail.post.commentCount,
    isLike,
    isSave,
  ];
}

final class PostError extends PostState {
  const PostError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
