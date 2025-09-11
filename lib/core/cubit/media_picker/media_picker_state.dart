import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class MediaPickerState extends Equatable {
  const MediaPickerState();
}

final class MediaPickerInitial extends MediaPickerState {
  const MediaPickerInitial();

  @override
  List<Object?> get props => [];
}

final class MediaPickerLoading extends MediaPickerState {
  const MediaPickerLoading();

  @override
  List<Object?> get props => [];
}

class MediaPickerPicked extends MediaPickerState {
  final File file;
  final bool isVideo;

  const MediaPickerPicked(this.file, {this.isVideo = false});

  @override
  List<Object?> get props => [isVideo, file];
}

class MediaPickerError extends MediaPickerState {
  final String message;

  const MediaPickerError(this.message);

  @override
  List<Object?> get props => [message];
}
