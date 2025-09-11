import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/cubit/media_picker/media_picker_cubit.dart';
import 'package:social_network/core/di/injection.dart';
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_cubit.dart';
import 'package:social_network/features/authentication/presentation/auth_loader/bloc/auth_cubit.dart';
import 'package:social_network/features/authentication/presentation/login/bloc/login_cubit.dart';
import 'package:social_network/features/authentication/presentation/account_picker/screen/account_picker.dart';
import 'package:social_network/features/authentication/presentation/auth_loader/screen/auth_loading_screen.dart';
import 'package:social_network/features/authentication/presentation/login/screen/login_screen.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_cubit.dart';
import 'package:social_network/features/authentication/presentation/signup/screen/signup_screen.dart';
import 'package:social_network/features/home/home_screen.dart';
import 'package:social_network/features/main/presentation/main_screen.dart';
import 'package:social_network/features/post/presntation/bloc/create_post/create_post_cubit.dart';
import 'package:social_network/features/post/presntation/screen/create_post_screen.dart';
import 'package:social_network/features/splash/presentation/screen/splash_screen.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/bloc/profile_onboarding_cubit.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/screen/profile_onboarding_screen.dart';

import 'app_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static Future<T?> push<T extends Object?>(AppRoutes route, {Object? extra}) =>
      router.push(route.fullPath, extra: extra);

  static void go(AppRoutes route, {Object? extra}) =>
      router.go(route.fullPath, extra: extra);

  static void pop<T extends Object?>([T? result]) => router.pop(result);

  static GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    // navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        builder: (context, state) => SplashScreen(),
      ),

      ///Auth
      GoRoute(
        path: AppRoutes.auth.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: AuthLoadingScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SignUpCubit>(),
          child: SignUpScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.accountPicker.path,
        builder: (context, state) {
          final accounts = state.extra as List<User>;
          return BlocProvider(
            create: (_) => getIt<AccountPickerCubit>(param1: accounts),
            child: AccountPickerScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.logIn.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<LogInCubit>(),
          child: LogInScreen(),
        ),
      ),


      /// Profile onboarding
      GoRoute(
        path: AppRoutes.profileOnBoarding.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ProfileOnBoardingCubit>(),
          child: ProfileOnboardingScreen(),
        ),
      ),

      ///main
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainScreen(navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                builder: (context, state) => HomeScreen(),
              ),
            ],
          ),
        ],
      ),

      //----------------------------create post----------------------------------
      GoRoute(
        path: AppRoutes.createPost.path,
        // parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<CreatePostCubit>()),
            BlocProvider(create: (_) => getIt<MediaPickerCubit>()),
          ],
          child: CreatePostScreen(),
        ),
        routes: [
          // GoRoute(
          //   parentNavigatorKey: _rootNavigatorKey,
          //   path: AppRoutes.editPost.path,
          //   builder: (context, state) {
          //     final cubit = state.extra as CreatePostCubit;
          //     return BlocProvider.value(value: cubit, child: EditPostScreen());
          //   },
          // ),
          // GoRoute(
          //   parentNavigatorKey: _rootNavigatorKey,
          //   path: AppRoutes.uploadPost.path,
          //   builder: (context, state) {
          //     final cubit = state.extra as CreatePostCubit;
          //     return BlocProvider.value(
          //       value: cubit,
          //       child: UploadingPostScreen(),
          //     );
          //   },
          // ),
        ],
      ),
    ],
  );
}
