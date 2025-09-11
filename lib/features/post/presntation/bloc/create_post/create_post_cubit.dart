import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/post/domain/usecase/create_post_usecase.dart';
import 'package:social_network/features/post/presntation/bloc/create_post/create_post_state.dart';

@injectable
class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit({required CreatePostUseCase createPostUseCase})
    : _createPostUseCase = createPostUseCase,
      super(const SelectingMediaState());

  final CreatePostUseCase _createPostUseCase;

  void selectPost(File file) async {
    emit(EditingPostState(file));
  }

  void editedPost(File file) async {
    emit(PreviewPostState(file));
  }

  void uploadPost(String content, File file) async {
    emit(UploadingPostState(content, file));
    var param = CreatePostUseCaseParam(content, file);
    var createResult = await _createPostUseCase(param);
    var newState = createResult.fold<CreatePostState>(
      (s) => PostUploadedState(),
      (f) => CreatePostError(f.message),
    );
    emit(newState);
  }

  void back() {
    var s = state;
    switch (s) {
      case SelectingMediaState():
      case EditingPostState():
        emit(SelectingMediaState());
      case PreviewPostState():
        emit(EditingPostState(s.mediaFile));
      case UploadingPostState():
      case PostUploadedState():
      case CreatePostError():
    }
  }
}
