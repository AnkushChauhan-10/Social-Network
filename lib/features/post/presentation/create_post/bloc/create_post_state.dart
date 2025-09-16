import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();
}

final class SelectingMediaState extends CreatePostState {
  const SelectingMediaState();

  @override
  List<Object?> get props => [];
}

final class EditingPostState extends CreatePostState {
  const EditingPostState(this.media);

  final File media;

  @override
  List<Object?> get props => [];
}

final class PreviewPostState extends CreatePostState {
  const PreviewPostState(this.mediaFile);

  final File mediaFile;

  @override
  List<Object?> get props => [];
}

final class UploadingPostState extends CreatePostState {
  const UploadingPostState(this.content, this.media);

  final File media;
  final String content;

  @override
  List<Object?> get props => [];
}

class PostUploadedState extends CreatePostState {
  const PostUploadedState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

final class CreatePostError extends CreatePostState {
  const CreatePostError(this.message);

  final String message;

  @override
  List<Object?> get props => [];
}
