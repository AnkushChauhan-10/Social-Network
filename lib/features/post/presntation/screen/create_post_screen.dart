import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/cubit/media_picker/media_picker_cubit.dart';
import 'package:social_network/core/cubit/media_picker/media_picker_state.dart';
import 'package:social_network/features/post/presntation/bloc/create_post/create_post_cubit.dart';
import 'package:social_network/features/post/presntation/bloc/create_post/create_post_state.dart';
import 'package:social_network/features/post/presntation/screen/edit_post_screen.dart';
import 'package:social_network/features/post/presntation/screen/uploading_post_screen.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MediaPickerCubit, MediaPickerState>(
      listener: (context, state) {
        switch (state) {
          case MediaPickerInitial():
            break;
          case MediaPickerPicked():
            context.read<CreatePostCubit>().selectPost(state.file);
            break;
          case MediaPickerError():
            print(state.message);
            break;
          case MediaPickerLoading():
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          final cubit = context.read<CreatePostCubit>();
          final step = cubit.state;
          if (step is SelectingMediaState) {
            return true;
          } else {
            cubit.back();
            return false;
          }
        },
        child: BlocBuilder<CreatePostCubit, CreatePostState>(
          buildWhen: (prev, curr) =>
              (curr is SelectingMediaState ||
                  curr is EditingPostState ||
                  curr is PreviewPostState) &&
              curr != prev,
          builder: (context, state) {
            if (state is EditingPostState) return EditPostScreen(state);
            if (state is PreviewPostState) return UploadingPostScreen(state);
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<MediaPickerCubit>().pickImage(),
                    child: Text("Pick from Gallery"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
