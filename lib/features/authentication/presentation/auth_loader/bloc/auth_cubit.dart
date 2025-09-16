import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/authentication/presentation/auth_loader/bloc/auth_state.dart';
import 'package:social_network/features/session/domain/usecase/check_session_usecase.dart';
import 'package:social_network/features/user/domain/usecase/get_accounts_usecase.dart';
import 'package:social_network/features/user/domain/usecase/get_user_usecase.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required CheckSessionUseCase checkSessionUseCase,
    required GetAccountsUseCase getAccountUseCase,
    required GetUserUseCase getUserUseCase,
  }) : _checkSessionUseCase = checkSessionUseCase,
       _getAccountsUseCase = getAccountUseCase,
       _getUserUseCase = getUserUseCase,
       super(AuthLoading());

  final CheckSessionUseCase _checkSessionUseCase;
  final GetAccountsUseCase _getAccountsUseCase;
  final GetUserUseCase _getUserUseCase;

  Future<void> checkAuth() async {
    emit(AuthLoading());
    final session = await _checkSessionUseCase();
    if (session.isSuccess) {
      await _getUserUseCase();
      emit(Authenticated());
    } else {
      final accounts = _getAccountsUseCase();
      var newState = accounts.fold<AuthState>(
        (s) => s.isNotEmpty ? ShowAccountPicker(s) : Unauthenticated(),
        (f) => Unauthenticated(),
      );
      emit(newState);
    }
  }
}
