import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/di/injection.dart';
import 'package:social_network/features/post/presentation/post/bloc/post_cubit.dart';
import 'package:social_network/features/post/presentation/post/bloc/post_state.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    var bloc = getIt<PostCubit>();
    return BlocBuilder<PostCubit, PostState>(
      bloc: bloc..loadPost(id),
      builder: (BuildContext context, PostState state) {
        return switch (state) {
          PostInitial() => Text("initial"),
          PostLoading() => CircularProgressIndicator(),
          PostSuccess() => Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (user info)
                ListTile(
                  leading: CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: state.postDetail.userProfileUrl,
                    ),
                  ),
                  title: Text(
                    state.postDetail.userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    state.postDetail.post.createdAt.toLocal().toString(),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),

                // Post content (image + text)
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: CachedNetworkImage(
                    imageUrl: state.postDetail.post.mediaUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(state.postDetail.post.content),
                ),

                const Divider(height: 1),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        state.isLike ? Icons.favorite : Icons.favorite_border,
                        color: state.isLike ? Colors.red : null,
                      ),
                      onPressed: () {
                        state.isLike ? bloc.dislikePost() : bloc.likePost();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment_outlined),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          PostError() => Text(state.message),
        };
      },
    );
  }
}
