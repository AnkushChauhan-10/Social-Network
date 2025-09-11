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
import 'package:social_network/core/storage/supabase_media_data_source.dart'
    as _i478;
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
import 'package:social_network/features/post/data/data_source/post_remote_data_source.dart'
    as _i1;
import 'package:social_network/features/post/data/repository/post_repo_impl.dart'
    as _i1044;
import 'package:social_network/features/post/domain/repository/post_repo.dart'
    as _i242;
import 'package:social_network/features/post/domain/usecase/create_post_usecase.dart'
    as _i435;
import 'package:social_network/features/post/domain/usecase/get_user_posts_usecase.dart'
    as _i678;
import 'package:social_network/features/post/presntation/bloc/create_post/create_post_cubit.dart'
    as _i865;
import 'package:social_network/features/session/data/data_source/session_local_data_source.dart'
    as _i187;
import 'package:social_network/features/session/data/repository/session_repo_impl.dart'
    as _i675;
import 'package:social_network/features/session/domain/repository/session_repo.dart'
    as _i573;
import 'package:social_network/features/session/domain/usecase/check_session_usecase.dart'
    as _i214;
import 'package:social_network/features/user/data/data_source/account_picker_local_data_source.dart'
    as _i663;
import 'package:social_network/features/user/data/data_source/user_local_data_source.dart'
    as _i240;
import 'package:social_network/features/user/data/data_source/user_remote_data_source.dart'
    as _i457;
import 'package:social_network/features/user/data/repository/account_picker_repo_impl.dart'
    as _i12;
import 'package:social_network/features/user/data/repository/user_repo_impl.dart'
    as _i478;
import 'package:social_network/features/user/domain/entities/user.dart'
    as _i531;
import 'package:social_network/features/user/domain/repository/account_picker_repo.dart'
    as _i17;
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
    await gh.factoryAsync<_i979.Box<dynamic>>(
      () => hiveModule.userCacheBox,
      instanceName: 'User_box',
      preResolve: true,
    );
    await gh.factoryAsync<_i979.Box<dynamic>>(
      () => hiveModule.accountListBox,
      instanceName: 'account_list_box',
      preResolve: true,
    );
    gh.lazySingleton<_i1.PostRemoteDataSource>(
      () => _i1.PostRemoteDataSourceImpl(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i457.UserRemoteDataSource>(
      () => _i457.UserRemoteDataSourceImpl(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i240.UserLocalDataSource>(
      () => _i240.UserLocalDataSourceImpl(
        hive: gh<_i979.Box<dynamic>>(instanceName: 'User_box'),
      ),
    );
    gh.lazySingleton<_i1030.AuthRemoteDataSource>(
      () => _i1030.AuthRemoteDataSourceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i663.AccountPickerLocalDataSource>(
      () => _i663.AccountPickerLocalDataSourceImpl(
        box: gh<_i979.Box<dynamic>>(instanceName: 'account_list_box'),
      ),
    );
    gh.lazySingleton<_i478.SupabaseMediaDataSource>(
      () => _i478.SupabaseMediaDataSourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i187.SessionLocalDataSource>(
      () => _i187.SessionLocalDataSourceImpl(
        secureStorage: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i242.PostRepo>(
      () => _i1044.PostRepoImpl(
        postRemoteDataSource: gh<_i1.PostRemoteDataSource>(),
        supabaseMediaDataSource: gh<_i478.SupabaseMediaDataSource>(),
      ),
    );
    gh.factory<_i678.GetUserPostsUseCase>(
      () => _i678.GetUserPostsUseCase(postRepo: gh<_i242.PostRepo>()),
    );
    gh.lazySingleton<_i17.AccountPickerRepo>(
      () => _i12.AccountPickerRepoImpl(
        accountPickerLocalDataSource: gh<_i663.AccountPickerLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i228.AuthRepo>(
      () => _i565.AuthRepoImpl(
        authRemoteDataSource: gh<_i1030.AuthRemoteDataSource>(),
        connectivity: gh<_i895.Connectivity>(),
      ),
    );
    gh.lazySingleton<_i33.UserRepo>(
      () => _i478.UserRepoImpl(
        connectivity: gh<_i895.Connectivity>(),
        userRemoteDataSource: gh<_i457.UserRemoteDataSource>(),
        userLocalDataSource: gh<_i240.UserLocalDataSource>(),
        supabaseMediaDataSource: gh<_i478.SupabaseMediaDataSource>(),
      ),
    );
    gh.lazySingleton<_i573.SessionRepo>(
      () => _i675.SessionRepoImpl(
        sessionLocalDataSource: gh<_i187.SessionLocalDataSource>(),
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
    gh.factory<_i115.SignUpUseCase>(
      () => _i115.SignUpUseCase(
        sessionRepo: gh<_i573.SessionRepo>(),
        authRepo: gh<_i228.AuthRepo>(),
        userRepo: gh<_i33.UserRepo>(),
      ),
    );
    gh.factory<_i252.GetUserUseCase>(
      () => _i252.GetUserUseCase(
        userRepo: gh<_i33.UserRepo>(),
        accountPickerRepo: gh<_i17.AccountPickerRepo>(),
        sessionRepo: gh<_i573.SessionRepo>(),
      ),
    );
    gh.factory<_i929.UpdateProfilePicUseCase>(
      () => _i929.UpdateProfilePicUseCase(
        userRepo: gh<_i33.UserRepo>(),
        sessionRepo: gh<_i573.SessionRepo>(),
      ),
    );
    gh.factory<_i834.SignUpCubit>(
      () => _i834.SignUpCubit(signUpUseCase: gh<_i115.SignUpUseCase>()),
    );
    gh.factory<_i765.LoginUserIdUseCase>(
      () => _i765.LoginUserIdUseCase(sessionRepo: gh<_i573.SessionRepo>()),
    );
    gh.factory<_i214.CheckSessionUseCase>(
      () => _i214.CheckSessionUseCase(sessionRepo: gh<_i573.SessionRepo>()),
    );
    gh.factory<_i905.LogInUseCase>(
      () => _i905.LogInUseCase(
        authRepo: gh<_i228.AuthRepo>(),
        sessionRepo: gh<_i573.SessionRepo>(),
      ),
    );
    gh.factoryParam<_i90.AccountPickerCubit, List<_i531.User>, dynamic>(
      (user, _) => _i90.AccountPickerCubit(
        user,
        removeUserUseCase: gh<_i624.RemoveUserUseCase>(),
        loginWithUserId: gh<_i765.LoginUserIdUseCase>(),
      ),
    );
    gh.factory<_i706.LogOutUseCase>(
      () => _i706.LogOutUseCase(
        authRepo: gh<_i228.AuthRepo>(),
        userRepo: gh<_i33.UserRepo>(),
        sessionRepo: gh<_i573.SessionRepo>(),
      ),
    );
    gh.factory<_i1018.LogInCubit>(
      () => _i1018.LogInCubit(logInUseCase: gh<_i905.LogInUseCase>()),
    );
    gh.factory<_i810.AuthCubit>(
      () => _i810.AuthCubit(
        checkSessionUseCase: gh<_i214.CheckSessionUseCase>(),
        getAccountUseCase: gh<_i650.GetAccountsUseCase>(),
        getUserUseCase: gh<_i252.GetUserUseCase>(),
      ),
    );
    gh.factory<_i435.CreatePostUseCase>(
      () => _i435.CreatePostUseCase(
        postRepo: gh<_i242.PostRepo>(),
        sessionRepo: gh<_i573.SessionRepo>(),
      ),
    );
    gh.factory<_i278.ProfileOnBoardingCubit>(
      () => _i278.ProfileOnBoardingCubit(
        updateProfilePicUseCase: gh<_i929.UpdateProfilePicUseCase>(),
        getUserUseCase: gh<_i252.GetUserUseCase>(),
      ),
    );
    gh.factory<_i865.CreatePostCubit>(
      () => _i865.CreatePostCubit(
        createPostUseCase: gh<_i435.CreatePostUseCase>(),
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
