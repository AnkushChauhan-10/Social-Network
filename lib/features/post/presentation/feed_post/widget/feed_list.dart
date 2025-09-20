import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/di/injection.dart';
import 'package:social_network/features/post/presentation/feed_post/bloc/feed_post_cubit.dart';
import 'package:social_network/features/post/presentation/feed_post/bloc/feed_post_state.dart';
import 'package:social_network/features/post/presentation/post/widgets/post_tile.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedPostCubit, FeedPostState>(
      bloc: getIt<FeedPostCubit>()..loadFeed(),
      builder: (BuildContext context, FeedPostState state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            if (index < state.postList.length) {
              return PostTile(postCubit: state.postList.elementAt(index));
            } else {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
          separatorBuilder: (context, index) => SizedBox(height:AppSizes.xs),
          itemCount: state.postList.length+1,
        );
      },
    );
  }
}
