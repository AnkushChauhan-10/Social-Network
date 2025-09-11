import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/authentication/domain/usecase/signup_usecase.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required SignUpUseCase signUpUseCase})
    : _signUpUseCase = signUpUseCase,
      super(const SignUpEmail());

  final SignUpUseCase _signUpUseCase;

  void submitEmail(String email) async {
    emit(SignUpEmail().loading());
    await Future.delayed(Duration(milliseconds: 300));
    emit(SignUpEmail().complete(email));
    _nextStep();
  }

  void submitPassword(String password) async {
    var passwordState = state;
    if (passwordState is SignUpPassword) {
      emit(passwordState.loading());
      await Future.delayed(Duration(milliseconds: 300));
      emit(passwordState.complete(password));
      _nextStep();
    }
  }

  void submitUserName(String userName) async {
    var userNameState = state;
    if (userNameState is SignUpUserName) {
      emit(userNameState.loading());
      await Future.delayed(Duration(milliseconds: 300));
      emit(userNameState.complete(userName));
      _nextStep();
    }
  }

  void createUser(String name) async {
    var createUserState = state;
    if (createUserState is SignUpCreateUser) {
      emit(createUserState.loading());
      var param = SignUpParam(
        name: name,
        email: createUserState.userNameState.passwordState.emailCompleted.email,
        password: createUserState.userNameState.passwordState.password,
        userName: createUserState.userNameState.userName,
      );
      var create = await _signUpUseCase.call(param);
      SignUpCreateUser newState = create.fold(
        (user) => createUserState.success(user.uId),
        (f) => createUserState.error(f.message),
      );
      emit(newState);
    }
  }

  void _nextStep() {
    var completedState = state;
    if (completedState is Completed) {
      var newState = (completedState as Completed).toNext();
      emit(newState);
    }
  }

  bool onBack() {
    var curr = state;
    switch (curr) {
      case SignUpEmail():
        return true;
      case SignUpPassword():
        emit(curr.emailCompleted);
        return false;
      case SignUpUserName():
        emit(curr.passwordState);
        return false;
      case SignUpCreateUser():
        return false;
    }
  }
}
