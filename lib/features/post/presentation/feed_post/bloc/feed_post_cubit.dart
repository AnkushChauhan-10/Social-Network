import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/di/injection.dart';
import 'package:social_network/features/post/domain/usecase/post_collection/get_feed_posts_usecase.dart';
import 'package:social_network/features/post/presentation/feed_post/bloc/feed_post_state.dart';
import 'package:social_network/features/post/presentation/post/bloc/post_cubit.dart';

@injectable
class FeedPostCubit extends Cubit<FeedPostState> {
  FeedPostCubit({required GetFeedPostUseCase getFeedPostUseCase})
    : _feedPostUseCase = getFeedPostUseCase,
      super(FeedPostInitial());
  final GetFeedPostUseCase _feedPostUseCase;

  void loadFeed() async {
    emit(FeedPostLoading(state.postList));
    var param = GetFeedPostParam();
    var posts = await _feedPostUseCase(param);
    var newState = posts.fold<FeedPostState>(
      (s) {
        List<PostCubit> list = s.map<PostCubit>((id)=>getIt<PostCubit>(param1: id)).toList();
        return FeedPostSuccess(list);
      },
      (f) => FeedPostError(f.message, state.postList),
    );
    emit(newState);
  }
}
