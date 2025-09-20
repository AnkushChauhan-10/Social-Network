import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/di/injection.dart';
import 'package:social_network/features/authentication/domain/usecase/log_out_usecase.dart';
import 'package:social_network/features/post/presentation/user_posts/bloc/user_post_cubit.dart';
import 'package:social_network/features/post/presentation/user_posts/widgets/user_post_grid.dart';
import 'package:social_network/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:social_network/features/profile/presentation/bloc/profile_state.dart';
import 'package:social_network/features/profile/presentation/widget/drawer.dart';
import 'package:social_network/features/profile/presentation/widget/sliver_tab_delegate.dart';
import 'package:social_network/features/profile/presentation/widget/user_detail_widget.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final UserPostCubit postCubit;
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    postCubit = context.read<UserPostCubit>();
    profileCubit = context.read<ProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          context.read<ProfileCubit>().loadCurrentUser();
        }
        var s = state;
        return Scaffold(
          endDrawer: s is ProfileSuccess
              ? CustomDrawer(
                  name: s.user.userName,
                  email: s.user.email,
                  url: s.user.profilePicUrl,
                  onLogOut: () async {
                    var logOut = getIt.call<LogOutUseCase>();
                    await logOut.call();
                    AppRouter.push(AppRoutes.auth);
                  },
                )
              : null,
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                    SliverAppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_outline, size: AppSizes.md),
                          SizedBox(width: AppSizes.xs),
                          Text(s is ProfileSuccess ? s.user.userName : "User"),
                        ],
                      ),
                    ),
                    if (state is ProfileSuccess) ...[
                      SliverToBoxAdapter(
                        child: UserDetailWidget(user: state.user),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverTabBarDelegate(
                          TabBar(
                            controller: tabController,
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(width: 3),
                              insets: EdgeInsets.symmetric(horizontal: 30),
                            ),
                            tabs: [
                              Tab(icon: Icon(Icons.grid_on)),
                              Tab(icon: Icon(Icons.person_pin)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
              body: switch (state) {
                ProfileInitial() => Center(child: CircularProgressIndicator()),
                ProfileLoading() => Center(child: CircularProgressIndicator()),
                ProfileSuccess() => TabBarView(
                  controller: tabController,
                  children: [
                    UserPostGrid(postCubit..loadPost(state.user.uId)),
                    Center(child: Text("Tagged posts")),
                  ],
                ),
                ProfileError() => Center(child: Text(state.message)),
              },
            ),
          ),
        );
      },
    );
  }
}
