import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/post/domain/entities/post.dart';
import 'package:social_network/features/post/domain/usecase/post_action/dislike_post_usecase.dart';
import 'package:social_network/features/post/domain/usecase/post_action/like_post_usecase.dart';
import 'package:social_network/features/post/domain/usecase/post_query/get_post_detail_usecase.dart';
import 'package:social_network/features/post/presentation/post/bloc/post_state.dart';

@injectable
class PostCubit extends Cubit<PostState> {
  PostCubit(
    @factoryParam Post post, {
    required GetPostDetailsUseCase postDetailsUseCase,
    required LikePostUseCase likePostUseCase,
    required DislikePostUseCase dislikePostUseCase,
  }) : _postDetailsUseCase = postDetailsUseCase,
       _dislikePostUseCase = dislikePostUseCase,
       _likePostUseCase = likePostUseCase,
       _post = post,
       super(PostInitial());

  final GetPostDetailsUseCase _postDetailsUseCase;
  final LikePostUseCase _likePostUseCase;
  final DislikePostUseCase _dislikePostUseCase;

  final Post _post;

  void loadPost() async {
    if (state is! PostInitial) return;
    emit(PostLoading());
    var postResult = await _postDetailsUseCase(_post);
    var newState = postResult.fold<PostState>(
      (post) => PostSuccess(post, post.isLike, false, post.post.likesCount),
      (f) => PostError(f.message),
    );
    emit(newState);
  }

  void toggleLike() async {
    var s = state;
    if (s is PostSuccess && !s.isLike) {
      emit(PostSuccess(s.postDetail, true, s.isSave, s.likeCount + 1));
      await _likePostUseCase(s.postDetail.post.id);
    } else if (s is PostSuccess && s.isLike) {
      emit(PostSuccess(s.postDetail, false, s.isSave, s.likeCount - 1));
      await _dislikePostUseCase(s.postDetail.post.id);
    }
  }
}
