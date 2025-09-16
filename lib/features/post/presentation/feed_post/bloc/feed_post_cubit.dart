import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/post/domain/usecase/post_collection/get_feed_posts_usecase.dart';
import 'package:social_network/features/post/presentation/feed_post/bloc/feed_post_state.dart';

@injectable
class FeedPostCubit extends Cubit<FeedPostState> {
  FeedPostCubit({required GetFeedPostUseCase getFeedPostUseCase})
    : _feedPostUseCase = getFeedPostUseCase,
      super(FeedPostInitial());
  final GetFeedPostUseCase _feedPostUseCase;

  void loadFeed() async {
    emit(FeedPostLoading(state.postIdList));
    var param = GetFeedPostParam();
    var posts = await _feedPostUseCase(param);
    var newState = posts.fold<FeedPostState>(
      (s) => FeedPostSuccess(s),
      (f) => FeedPostError(f.message, state.postIdList),
    );
    emit(newState);
  }
}
