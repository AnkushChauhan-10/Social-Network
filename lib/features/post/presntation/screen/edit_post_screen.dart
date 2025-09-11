import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/features/post/presntation/bloc/create_post/create_post_cubit.dart';
import 'package:social_network/features/post/presntation/bloc/create_post/create_post_state.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen(this.state, {super.key});

  final EditingPostState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Image.file(state.media)),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () =>
                context.read<CreatePostCubit>().editedPost(state.media),
            child: Text("Next"),
          ),
        ],
      ),
    );
  }
}
