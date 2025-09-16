import 'package:equatable/equatable.dart';

sealed class FeedPostState extends Equatable {
  const FeedPostState(this.postIdList);

  final List<String> postIdList;

  @override
  List<Object?> get props => [postIdList];
}

final class FeedPostInitial extends FeedPostState {
  const FeedPostInitial() : super(const []);
}

final class FeedPostLoading extends FeedPostState {
  const FeedPostLoading(super.postIdList);
}

final class FeedPostSuccess extends FeedPostState {
  const FeedPostSuccess(super.postIdList);
}

final class FeedPostError extends FeedPostState {
  const FeedPostError(this.message, super.postIdList);

  final String message;
}
