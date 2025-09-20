import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/widget/circular_network_image.dart';
import 'package:social_network/features/post/presentation/post/bloc/post_cubit.dart';
import 'package:social_network/features/post/presentation/post/bloc/post_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_network/features/post/presentation/post/widgets/post_action.dart';
import 'package:social_network/features/post/presentation/post/widgets/post_contain.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.postCubit});

  final PostCubit postCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      bloc: postCubit..loadPost(),
      builder: (BuildContext context, PostState state) {
        return switch (state) {
          PostInitial() => Text("initial"),
          PostLoading() => _PostShimmer(),
          PostSuccess() => Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (user info)
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  leading: CircularNetworkImage(
                    imageUrl: state.postDetail.userProfileUrl,
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
                  aspectRatio: 4 / 5,
                  child: CachedNetworkImage(
                    imageUrl: state.postDetail.post.mediaUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                const Divider(height: 1),

                // Action buttons
                PostActions(
                  isLiked: state.isLike,
                  likesCount: state.likeCount,
                  commentsCount: state.postDetail.post.commentCount,
                  onLike: () => postCubit.toggleLike(),
                  onComment: () {},
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PostContent(
                    username: state.postDetail.userName,
                    content: state.postDetail.post.content,
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
          PostError() => Text(state.message),
        };
      },
    );
  }
}

class _PostShimmer extends StatelessWidget {
  const _PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Skeletonizer(
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header skeleton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(width: 24, height: 24, color: Colors.white),
                ],
              ),
            ),

            // Post image skeleton
            AspectRatio(
              aspectRatio: 4 / 5,
              child: Container(width: double.infinity, color: Colors.white),
            ),

            const Divider(height: 1),

            // Action buttons skeleton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: List.generate(
                  2,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: index == 0 ? 20 : 0),
                    child: Row(
                      children: [
                        Container(width: 24, height: 24, color: Colors.white),
                        const SizedBox(width: 6),
                        Container(width: 20, height: 10, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Post content skeleton
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: List.generate(
                  2,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
