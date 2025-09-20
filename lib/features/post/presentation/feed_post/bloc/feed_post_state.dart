import 'package:equatable/equatable.dart';
import 'package:social_network/features/post/presentation/post/bloc/post_cubit.dart';

sealed class FeedPostState extends Equatable {
  const FeedPostState(this.postList);

  final List<PostCubit> postList;

  @override
  List<Object?> get props => [postList];
}

final class FeedPostInitial extends FeedPostState {
  const FeedPostInitial() : super(const []);
}

final class FeedPostLoading extends FeedPostState {
  const FeedPostLoading(super.postList);
}

final class FeedPostSuccess extends FeedPostState {
  const FeedPostSuccess(super.postList);
}

final class FeedPostError extends FeedPostState {
  const FeedPostError(this.message, super.postList);

  final String message;
}
