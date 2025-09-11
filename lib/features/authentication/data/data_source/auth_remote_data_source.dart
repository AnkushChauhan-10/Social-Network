import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<String> signUp(String email, String password);

  Future<String> logIn(String email, String password);

  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  const AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  @override
  Future<String> signUp(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user == null) throw AuthException();
    return userCredential.user!.uid;
  }

  @override
  Future<String> logIn(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user == null) throw AuthException();
    return userCredential.user!.uid;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
