import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';
import 'package:social_network/core/error/failure.dart';
import 'package:social_network/core/utils/connectivity_extension.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:social_network/features/authentication/domain/repository/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  const AuthRepoImpl(
      {required AuthRemoteDataSource authRemoteDataSource, required Connectivity connectivity})
      :_connectivity = connectivity,
        _authRemoteDataSource = authRemoteDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  final Connectivity _connectivity;

  @override
  FutureResult<String> signup(String email, String password) async {
    try {
      if(!await _connectivity.isInternet) throw NetworkFailure();
      var userId = await _authRemoteDataSource.signUp(email, password);
      return Result.success(userId);
    } on FirebaseAuthException catch (e) {
      return Result.failure(AuthFailure(e.message));
    } on AuthException catch (e) {
      return Result.failure(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  FutureResult<String> login(String email, String password) async {
    try {
      if(!await _connectivity.isInternet) throw NetworkFailure();
      var userId = await _authRemoteDataSource.logIn(email, password);
      return Result.success(userId);
    } on FirebaseAuthException catch (e) {
      return Result.failure(AuthFailure(e.message));
    } on AuthException catch (e) {
      return Result.failure(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  FutureResult<void> signOut() async {
    try {
      if(!await _connectivity.isInternet) throw NetworkFailure();
      await _authRemoteDataSource.signOut();
      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(AuthFailure(e.message));
    } on AuthException catch (e) {
      return Result.failure(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return Result.failure(NetworkFailure(e.message));
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }
}
