// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:social_network/core/cubit/media_picker/media_picker_cubit.dart'
    as _i158;
import 'package:social_network/core/di/connectivity_module.dart' as _i725;
import 'package:social_network/core/di/firebase_module.dart' as _i418;
import 'package:social_network/core/di/flutter_secure_storage_module.dart'
    as _i616;
import 'package:social_network/core/di/hive_module.dart' as _i745;
import 'package:social_network/core/di/supabase_module.dart' as _i802;
import 'package:social_network/features/authentication/data/data_source/auth_remote_data_source.dart'
    as _i1030;
import 'package:social_network/features/authentication/data/repository/auth_repo_impl.dart'
    as _i565;
import 'package:social_network/features/authentication/domain/repository/auth_repo.dart'
    as _i228;
import 'package:social_network/features/authentication/domain/usecase/log_out_usecase.dart'
    as _i706;
import 'package:social_network/features/authentication/domain/usecase/login_usecase.dart'
    as _i905;
import 'package:social_network/features/authentication/domain/usecase/login_with_user_usecase.dart'
    as _i765;
import 'package:social_network/features/authentication/domain/usecase/signup_usecase.dart'
    as _i115;
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_cubit.dart'
    as _i90;
import 'package:social_network/features/authentication/presentation/auth_loader/bloc/auth_cubit.dart'
    as _i810;
import 'package:social_network/features/authentication/presentation/login/bloc/login_cubit.dart'
    as _i1018;
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_cubit.dart'
    as _i834;
import 'package:social_network/features/post/data/data_source/remote/post_action_remote_data_source.dart'
    as _i910;
import 'package:social_network/features/post/data/data_source/remote/post_collection_remote_data_source.dart'
    as _i605;
import 'package:social_network/features/post/data/data_source/remote/post_creation_remote_data_source.dart'
    as _i160;
import 'package:social_network/features/post/data/data_source/remote/post_query_remote_data_source.dart'
    as _i942;
import 'package:social_network/features/post/data/repository/post_action_repo_impl.dart'
    as _i112;
import 'package:social_network/features/post/data/repository/post_collection_repo_impl.dart'
    as _i926;
import 'package:social_network/features/post/data/repository/post_creation_repo_impl.dart'
    as _i549;
import 'package:social_network/features/post/data/repository/post_query_repo_impl.dart'
    as _i709;
import 'package:social_network/features/post/domain/entities/post.dart'
    as _i648;
import 'package:social_network/features/post/domain/repository/post_action_repo.dart'
    as _i190;
import 'package:social_network/features/post/domain/repository/post_collection_repo.dart'
    as _i667;
import 'package:social_network/features/post/domain/repository/post_creation_repo.dart'
    as _i818;
import 'package:social_network/features/post/domain/repository/post_query_repo.dart'
    as _i372;
import 'package:social_network/features/post/domain/usecase/create_post/create_post_usecase.dart'
    as _i522;
import 'package:social_network/features/post/domain/usecase/post_action/dislike_post_usecase.dart'
    as _i679;
import 'package:social_network/features/post/domain/usecase/post_action/like_post_usecase.dart'
    as _i243;
import 'package:social_network/features/post/domain/usecase/post_collection/get_feed_posts_usecase.dart'
    as _i94;
import 'package:social_network/features/post/domain/usecase/post_collection/get_user_posts_usecase.dart'
    as _i690;
import 'package:social_network/features/post/domain/usecase/post_query/get_post_detail_usecase.dart'
    as _i234;
import 'package:social_network/features/post/presentation/create_post/bloc/create_post_cubit.dart'
    as _i951;
import 'package:social_network/features/post/presentation/feed_post/bloc/feed_post_cubit.dart'
    as _i121;
import 'package:social_network/features/post/presentation/post/bloc/post_cubit.dart'
    as _i159;
import 'package:social_network/features/post/presentation/user_posts/bloc/user_post_cubit.dart'
    as _i70;
import 'package:social_network/features/profile/presentation/bloc/profile_cubit.dart'
    as _i488;
import 'package:social_network/features/user/data/data_source/local/account_picker_local_data_source.dart'
    as _i492;
import 'package:social_network/features/user/data/data_source/local/user_local_data_source.dart'
    as _i310;
import 'package:social_network/features/user/data/data_source/remote/user_remote_data_source.dart'
    as _i990;
import 'package:social_network/features/user/data/repository/account_picker_repo_impl.dart'
    as _i12;
import 'package:social_network/features/user/data/repository/user_query_repo_impl.dart'
    as _i1012;
import 'package:social_network/features/user/data/repository/user_repo_impl.dart'
    as _i478;
import 'package:social_network/features/user/domain/entities/user.dart'
    as _i531;
import 'package:social_network/features/user/domain/repository/account_picker_repo.dart'
    as _i17;
import 'package:social_network/features/user/domain/repository/user_query_repo.dart'
    as _i736;
import 'package:social_network/features/user/domain/repository/user_repo.dart'
    as _i33;
import 'package:social_network/features/user/domain/usecase/get_accounts_usecase.dart'
    as _i650;
import 'package:social_network/features/user/domain/usecase/get_user_usecase.dart'
    as _i252;
import 'package:social_network/features/user/domain/usecase/remove_user_usecase.dart'
    as _i624;
import 'package:social_network/features/user/domain/usecase/update_profile_pic_usecase.dart'
    as _i929;
import 'package:social_network/features/user/presentation/profile_onboarding/bloc/profile_onboarding_cubit.dart'
    as _i278;
import 'package:social_network/shared/media/data/data_source/media_remote_data_source.dart'
    as _i248;
import 'package:social_network/shared/media/data/repo/media_repo_impl.dart'
    as _i859;
import 'package:social_network/shared/media/domain/repo/media_repo.dart'
    as _i629;
import 'package:social_network/shared/session/data/data_source/session_local_data_source.dart'
    as _i790;
import 'package:social_network/shared/session/data/repository/session_repo_impl.dart'
    as _i1000;
import 'package:social_network/shared/session/domain/repository/session_repo.dart'
    as _i198;
import 'package:social_network/shared/session/domain/usecase/check_session_usecase.dart'
    as _i951;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final connectivityModule = _$ConnectivityModule();
    final firebaseModule = _$FirebaseModule();
    final flutterSecureStorageModule = _$FlutterSecureStorageModule();
    final supabaseModule = _$SupabaseModule();
    final hiveModule = _$HiveModule();
    gh.factory<_i158.MediaPickerCubit>(() => _i158.MediaPickerCubit());
    gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.fireStore);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => flutterSecureStorageModule.flutterSecureStorage,
    );
    gh.lazySingleton<_i454.SupabaseClient>(() => supabaseModule.supabase);
    gh.lazySingleton<_i910.PostActionRemoteDataSource>(
      () => _i910.PostActionRemoteDataSourceImpl(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i990.UserRemoteDataSource>(
      () => _i990.UserRemoteDataSourceImpl(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    await gh.factoryAsync<_i979.Box<dynamic>>(
      () => hiveModule.userCacheBox,
      instanceName: 'User_box',
      preResolve: true,
    );
    gh.lazySingleton<_i160.PostCreationRemoteDataSource>(
      () => _i160.PostCreationRemoteDataSourceImpl(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    await gh.factoryAsync<_i979.Box<dynamic>>(
      () => hiveModule.accountListBox,
      instanceName: 'account_list_box',
      preResolve: true,
    );
    gh.lazySingleton<_i605.PostCollectionRemoteDataSource>(
      () => _i605.PostCollectionRemoteDataSourceImpl(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i667.PostCollectionRepo>(
      () => _i926.PostCollectionRepoImpl(
        connectivity: gh<_i895.Connectivity>(),
        postCollectionDataSource: gh<_i605.PostCollectionRemoteDataSource>(),
      ),
    );
    gh.factory<_i736.UserQueryRepo>(
      () => _i1012.UserQueryRepoImpl(
        connectivity: gh<_i895.Connectivity>(),
        userRemoteDataSource: gh<_i990.UserRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i942.PostQueryRemoteDataSource>(
      () => _i942.PostQueryRemoteDataSourceImpl(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i492.AccountPickerLocalDataSource>(
      () => _i492.AccountPickerLocalDataSourceImpl(
        box: gh<_i979.Box<dynamic>>(instanceName: 'account_list_box'),
      ),
    );
    gh.lazySingleton<_i372.PostQueryRepo>(
      () => _i709.PostQueryRepoImpl(
        connectivity: gh<_i895.Connectivity>(),
        postQueryRemoteDataSource: gh<_i942.PostQueryRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i790.SessionLocalDataSource>(
      () => _i790.SessionLocalDataSourceImpl(
        secureStorage: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i690.GetUserPostsUseCase>(
      () => _i690.GetUserPostsUseCase(
        postQueryRepo: gh<_i372.PostQueryRepo>(),
        userQueryRepo: gh<_i736.UserQueryRepo>(),
      ),
    );
    gh.lazySingleton<_i1030.AuthRemoteDataSource>(
      () => _i1030.AuthRemoteDataSourceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i818.PostCreationRepo>(
      () => _i549.PostCreationRepoImpl(
        connectivity: gh<_i895.Connectivity>(),
        postCreationRemoteDataSource: gh<_i160.PostCreationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i190.PostActionRepo>(
      () => _i112.PostActionRepoImpl(
        connectivity: gh<_i895.Connectivity>(),
        postActionRemoteDataSource: gh<_i910.PostActionRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i17.AccountPickerRepo>(
      () => _i12.AccountPickerRepoImpl(
        accountPickerLocalDataSource: gh<_i492.AccountPickerLocalDataSource>(),
      ),
    );
    gh.factory<_i650.GetAccountsUseCase>(
      () => _i650.GetAccountsUseCase(
        accountPickerRepo: gh<_i17.AccountPickerRepo>(),
      ),
    );
    gh.factory<_i624.RemoveUserUseCase>(
      () => _i624.RemoveUserUseCase(
        accountPickerRepo: gh<_i17.AccountPickerRepo>(),
      ),
    );
    gh.lazySingleton<_i310.UserLocalDataSource>(
      () => _i310.UserLocalDataSourceImpl(
        hive: gh<_i979.Box<dynamic>>(instanceName: 'User_box'),
      ),
    );
    gh.lazySingleton<_i248.MediaRemoteDataSource>(
      () => _i248.MediaRemoteDataSourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i629.MediaRepo>(
      () => _i859.MediaRepoImpl(
        mediaRemoteDataSource: gh<_i248.MediaRemoteDataSource>(),
        connectivity: gh<_i895.Connectivity>(),
      ),
    );
    gh.factory<_i70.UserPostCubit>(
      () => _i70.UserPostCubit(
        getUserPostUseCase: gh<_i690.GetUserPostsUseCase>(),
      ),
    );
    gh.lazySingleton<_i228.AuthRepo>(
      () => _i565.AuthRepoImpl(
        authRemoteDataSource: gh<_i1030.AuthRemoteDataSource>(),
        connectivity: gh<_i895.Connectivity>(),
      ),
    );
    gh.lazySingleton<_i198.SessionRepo>(
      () => _i1000.SessionRepoImpl(
        sessionLocalDataSource: gh<_i790.SessionLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i33.UserRepo>(
      () => _i478.UserRepoImpl(
        connectivity: gh<_i895.Connectivity>(),
        userRemoteDataSource: gh<_i990.UserRemoteDataSource>(),
        userLocalDataSource: gh<_i310.UserLocalDataSource>(),
      ),
    );
    gh.factory<_i522.CreatePostUseCase>(
      () => _i522.CreatePostUseCase(
        postCreationRepo: gh<_i818.PostCreationRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
        mediaRepo: gh<_i629.MediaRepo>(),
        userRepo: gh<_i33.UserRepo>(),
      ),
    );
    gh.factory<_i252.GetUserUseCase>(
      () => _i252.GetUserUseCase(
        userRepo: gh<_i33.UserRepo>(),
        accountPickerRepo: gh<_i17.AccountPickerRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
      ),
    );
    gh.factory<_i905.LogInUseCase>(
      () => _i905.LogInUseCase(
        authRepo: gh<_i228.AuthRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
      ),
    );
    gh.factory<_i765.LoginUserIdUseCase>(
      () => _i765.LoginUserIdUseCase(sessionRepo: gh<_i198.SessionRepo>()),
    );
    gh.factory<_i951.CheckSessionUseCase>(
      () => _i951.CheckSessionUseCase(sessionRepo: gh<_i198.SessionRepo>()),
    );
    gh.factory<_i234.GetPostDetailsUseCase>(
      () => _i234.GetPostDetailsUseCase(
        postQueryRepo: gh<_i372.PostQueryRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
        userQueryRepo: gh<_i736.UserQueryRepo>(),
      ),
    );
    gh.factory<_i929.UpdateProfilePicUseCase>(
      () => _i929.UpdateProfilePicUseCase(
        userRepo: gh<_i33.UserRepo>(),
        mediaRepo: gh<_i629.MediaRepo>(),
        accountPickerRepo: gh<_i17.AccountPickerRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
      ),
    );
    gh.factory<_i679.DislikePostUseCase>(
      () => _i679.DislikePostUseCase(
        postActionRepo: gh<_i190.PostActionRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
      ),
    );
    gh.factory<_i243.LikePostUseCase>(
      () => _i243.LikePostUseCase(
        postActionRepo: gh<_i190.PostActionRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
      ),
    );
    gh.factory<_i115.SignUpUseCase>(
      () => _i115.SignUpUseCase(
        sessionRepo: gh<_i198.SessionRepo>(),
        authRepo: gh<_i228.AuthRepo>(),
        userRepo: gh<_i33.UserRepo>(),
      ),
    );
    gh.factory<_i1018.LogInCubit>(
      () => _i1018.LogInCubit(logInUseCase: gh<_i905.LogInUseCase>()),
    );
    gh.factory<_i94.GetFeedPostUseCase>(
      () => _i94.GetFeedPostUseCase(
        postCollectionRepo: gh<_i667.PostCollectionRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
      ),
    );
    gh.factory<_i951.CreatePostCubit>(
      () => _i951.CreatePostCubit(
        createPostUseCase: gh<_i522.CreatePostUseCase>(),
      ),
    );
    gh.factory<_i706.LogOutUseCase>(
      () => _i706.LogOutUseCase(
        authRepo: gh<_i228.AuthRepo>(),
        userRepo: gh<_i33.UserRepo>(),
        sessionRepo: gh<_i198.SessionRepo>(),
      ),
    );
    gh.factory<_i278.ProfileOnBoardingCubit>(
      () => _i278.ProfileOnBoardingCubit(
        updateProfilePicUseCase: gh<_i929.UpdateProfilePicUseCase>(),
        getUserUseCase: gh<_i252.GetUserUseCase>(),
      ),
    );
    gh.factory<_i810.AuthCubit>(
      () => _i810.AuthCubit(
        checkSessionUseCase: gh<_i951.CheckSessionUseCase>(),
        getAccountUseCase: gh<_i650.GetAccountsUseCase>(),
        getUserUseCase: gh<_i252.GetUserUseCase>(),
      ),
    );
    gh.factoryParam<_i159.PostCubit, _i648.Post, dynamic>(
      (post, _) => _i159.PostCubit(
        post,
        postDetailsUseCase: gh<_i234.GetPostDetailsUseCase>(),
        likePostUseCase: gh<_i243.LikePostUseCase>(),
        dislikePostUseCase: gh<_i679.DislikePostUseCase>(),
      ),
    );
    gh.factory<_i488.ProfileCubit>(
      () => _i488.ProfileCubit(getUserUseCase: gh<_i252.GetUserUseCase>()),
    );
    gh.factory<_i834.SignUpCubit>(
      () => _i834.SignUpCubit(signUpUseCase: gh<_i115.SignUpUseCase>()),
    );
    gh.factory<_i121.FeedPostCubit>(
      () => _i121.FeedPostCubit(
        getFeedPostUseCase: gh<_i94.GetFeedPostUseCase>(),
      ),
    );
    gh.factoryParam<_i90.AccountPickerCubit, List<_i531.User>, dynamic>(
      (user, _) => _i90.AccountPickerCubit(
        user,
        removeUserUseCase: gh<_i624.RemoveUserUseCase>(),
        loginWithUserId: gh<_i765.LoginUserIdUseCase>(),
      ),
    );
    return this;
  }
}

class _$ConnectivityModule extends _i725.ConnectivityModule {}

class _$FirebaseModule extends _i418.FirebaseModule {}

class _$FlutterSecureStorageModule extends _i616.FlutterSecureStorageModule {}

class _$SupabaseModule extends _i802.SupabaseModule {}

class _$HiveModule extends _i745.HiveModule {}
