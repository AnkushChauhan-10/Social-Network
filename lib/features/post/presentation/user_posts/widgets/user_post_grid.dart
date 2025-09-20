import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/features/post/presentation/user_posts/bloc/user_post_cubit.dart';
import 'package:social_network/features/post/presentation/user_posts/bloc/user_post_state.dart';

class UserPostGrid extends StatelessWidget {
  const UserPostGrid(this.cubit, {super.key});

  final UserPostCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostCubit, UserPostState>(
      bloc: cubit,
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 3 / 4,
              ),
              itemCount: state.postList.length,
              itemBuilder: (context, index) {
                if (index >= state.postList.length - 1) {
                  cubit.load();
                }
                return CachedNetworkImage(
                  imageUrl: state.postList[index].mediaUrl,
                  placeholder: (context, str) => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      border: BoxBorder.all(
                        color: Theme.of(context).dividerColor,
                        width: 0.2,
                      ),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  fit: BoxFit.cover,
                );
              },
            ),
            if (state is UserPostLoading)
              state.postList.isEmpty
                  ? SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.sm),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
          ],
        );
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.postList.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: state.postList.length,
                  itemBuilder: (context, index) {
                    if (index >= state.postList.length - 1) {
                      print(
                        "-------------------------------------------------------",
                      );
                      cubit.load();
                    }
                    return CachedNetworkImage(
                      imageUrl: state.postList[index].mediaUrl,
                      placeholder: (context, str) => Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          border: BoxBorder.all(
                            color: Theme.of(context).dividerColor,
                            width: 0.2,
                          ),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            if (state is UserPostLoading)
              Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
