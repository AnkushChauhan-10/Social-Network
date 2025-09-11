import 'dart:io';

import 'package:equatable/equatable.dart';

// -----------------------------------core state ------------------------------------------
sealed class SignUpState extends Equatable {
  const SignUpState();
}

sealed class Loading {
  const Loading();
}

sealed class Error {
  const Error();
}

sealed class Completed {
  const Completed();

  SignUpState toNext();
}

// ------------------------------------Email State ---------------------------------------
class SignUpEmail extends SignUpState {
  const SignUpEmail();

  SignUpEmailCompleted complete(String email) => SignUpEmailCompleted._(email);

  SignUpEmailLoading loading() => SignUpEmailLoading._();

  SignUpEmailError error(String message) => SignUpEmailError._(message);

  @override
  List<Object?> get props => [];
}

class SignUpEmailLoading extends SignUpEmail implements Loading {
  const SignUpEmailLoading._();
}

final class SignUpEmailCompleted extends SignUpEmail implements Completed {
  const SignUpEmailCompleted._(this.email);

  final String email;

  @override
  SignUpPassword toNext() => SignUpPassword._(emailCompleted: this);

  @override
  List<Object?> get props => [email];
}

final class SignUpEmailError extends SignUpEmail implements Error {
  const SignUpEmailError._(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

//--------------------------------------Password State--------------------------------------
class SignUpPassword extends SignUpState {
  const SignUpPassword._({required this.emailCompleted});

  final SignUpEmailCompleted emailCompleted;

  SignUpPasswordCompleted complete(String password) =>
      SignUpPasswordCompleted._(password, emailCompleted: emailCompleted);

  SignUpPasswordLoading loading() =>
      SignUpPasswordLoading._(emailCompleted: emailCompleted);

  SignUpPasswordError error(String error) =>
      SignUpPasswordError._(error, emailCompleted: emailCompleted);

  @override
  List<Object?> get props => [emailCompleted];
}

final class SignUpPasswordLoading extends SignUpPassword implements Loading {
  const SignUpPasswordLoading._({required super.emailCompleted}) : super._();

  @override
  List<Object?> get props => [];
}

final class SignUpPasswordCompleted extends SignUpPassword
    implements Completed {
  const SignUpPasswordCompleted._(
    this.password, {
    required super.emailCompleted,
  }) : super._();

  final String password;

  @override
  SignUpUserName toNext() => SignUpUserName._(passwordState: this);

  @override
  List<Object?> get props => [password, super.emailCompleted];
}

final class SignUpPasswordError extends SignUpPassword implements Error {
  const SignUpPasswordError._(this.message, {required super.emailCompleted})
    : super._();

  final String message;

  @override
  List<Object?> get props => [message];
}

//--------------------------------------User name State----------------------------------------
class SignUpUserName extends SignUpState {
  const SignUpUserName._({required this.passwordState});

  final SignUpPasswordCompleted passwordState;

  SignUpUserNameCompleted complete(String userName) =>
      SignUpUserNameCompleted._(userName, passwordState: passwordState);

  SignUpUserNameLoading loading() =>
      SignUpUserNameLoading._(passwordState: passwordState);

  SignUpUserNameError error(String error) =>
      SignUpUserNameError._(error, passwordState: passwordState);

  @override
  List<Object?> get props => [passwordState];
}

final class SignUpUserNameLoading extends SignUpUserName implements Loading {
  const SignUpUserNameLoading._({required super.passwordState}) : super._();
}

final class SignUpUserNameError extends SignUpUserName implements Error {
  const SignUpUserNameError._(this.message, {required super.passwordState})
    : super._();

  final String message;
}

final class SignUpUserNameCompleted extends SignUpUserName
    implements Completed {
  const SignUpUserNameCompleted._(this.userName, {required super.passwordState})
    : super._();

  final String userName;

  @override
  SignUpCreateUser toNext() => SignUpCreateUser._(userNameState: this);

  @override
  List<Object?> get props => [userName, super.passwordState];
}

//-------------------------------------- CreateUser  ----------------------------
class SignUpCreateUser extends SignUpState {
  const SignUpCreateUser._({required this.userNameState});

  final SignUpUserNameCompleted userNameState;

  SignUpCreateUserLoading loading() =>
      SignUpCreateUserLoading._(userNameState: userNameState);

  SignUpCreateUserSuccess success(String name) =>
      SignUpCreateUserSuccess._(name, userNameState: userNameState);

  SignUpCreateUserError error(String message) =>
      SignUpCreateUserError._(message, userNameState: userNameState);

  @override
  List<Object?> get props => [userNameState];
}

final class SignUpCreateUserLoading extends SignUpCreateUser
    implements Loading {
  const SignUpCreateUserLoading._({required super.userNameState}) : super._();
}

final class SignUpCreateUserSuccess extends SignUpCreateUser {
  const SignUpCreateUserSuccess._(this.id, {required super.userNameState})
    : super._();

  final String id;

  @override
  List<Object?> get props => [id, super.userNameState];
}

final class SignUpCreateUserError extends SignUpCreateUser implements Error {
  const SignUpCreateUserError._(this.message, {required super.userNameState})
    : super._();

  final String message;
}
