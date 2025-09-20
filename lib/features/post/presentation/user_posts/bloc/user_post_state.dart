import 'package:equatable/equatable.dart';
import 'package:social_network/features/post/domain/entities/post.dart';

sealed class UserPostState extends Equatable {
  const UserPostState(this.postList, this.hasMore);

  final List<Post> postList;
  final bool hasMore;

  @override
  List<Object?> get props => [postList, hasMore];
}

final class UserPostInitial extends UserPostState {
  const UserPostInitial() : super(const [], true);
}

final class UserPostLoading extends UserPostState {
  const UserPostLoading(super.postList, super.hasMore);
}

final class UserPostSuccess extends UserPostState {
  const UserPostSuccess(super.postList, super.hasMore);
}

final class UserPostError extends UserPostState {
  const UserPostError(this.message, super.postList, super.hasMore);

  final String message;
}
