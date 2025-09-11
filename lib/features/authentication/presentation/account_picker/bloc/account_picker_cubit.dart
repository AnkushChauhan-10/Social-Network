import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/authentication/domain/usecase/login_with_user_usecase.dart';
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_state.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/usecase/remove_user_usecase.dart';

@injectable
class AccountPickerCubit extends Cubit<AccountPickerState> {
  AccountPickerCubit(
    @factoryParam List<User> user, {
    required RemoveUserUseCase removeUserUseCase,
    required LoginUserIdUseCase loginWithUserId,
  }) : _removeUserUseCase = removeUserUseCase,
       _loginWithUserId = loginWithUserId,
       super(AccountPickerInitial(user));

  final RemoveUserUseCase _removeUserUseCase;
  final LoginUserIdUseCase _loginWithUserId;

  Future<void> removeAccount(User user) async {
    emit(AccountPickerLoading(state.list, user));
    var result = await _removeUserUseCase(user);
    var newState = result.fold<AccountPickerState>(
      (s) {
        List<User> newList = state.list..remove(user);
        if (newList.isNotEmpty) return AccountPickerInitial(newList);
        return AccountPickerEmpty("");
      },
      (f) {
        return AccountPickerError(f.message, state.list);
      },
    );
    emit(newState);
  }

  Future<void> logInWithUser(User user) async {
    emit(AccountPickerLoading(state.list, user));
    var result = await _loginWithUserId(user.uId);
    var newState = result.fold<AccountPickerState>(
      (s) => AccountPikerSelected(user, state.list),
      (f) => AccountPickerError(f.message, state.list),
    );
    emit(newState);
  }
}
