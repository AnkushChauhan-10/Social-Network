import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/features/post/presentation/create_post/bloc/create_post_cubit.dart';
import 'package:social_network/features/post/presentation/create_post/bloc/create_post_state.dart';

class UploadingPostScreen extends StatelessWidget {
  const UploadingPostScreen(this.state, {super.key});

  final PreviewPostState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Image.file(state.mediaFile)),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.read<CreatePostCubit>().uploadPost(
              "content",
              state.mediaFile,
            ),
            child: Text("Upload"),
          ),
        ],
      ),
    );
  }
}
