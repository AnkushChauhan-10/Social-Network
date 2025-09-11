import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/cubit/media_picker/media_picker_state.dart';

@injectable
class MediaPickerCubit extends Cubit<MediaPickerState> {
  MediaPickerCubit() : super(const MediaPickerInitial());
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async => _pickMedia(ImageSource.gallery, false);

  Future<void> _pickMedia(ImageSource source, bool isVideo) async {
    try {
      XFile? file;
      if (isVideo) {
      } else {
        file = await _imagePicker.pickImage(source: source);
      }
      if (file != null) {
        emit(MediaPickerPicked(File(file.path), isVideo: isVideo));
      } else {
        emit(MediaPickerInitial());
      }
    } catch (e) {
      emit(MediaPickerError("Field to pick media: $e"));
    }
  }

  void clear() => emit(const MediaPickerInitial());
}
