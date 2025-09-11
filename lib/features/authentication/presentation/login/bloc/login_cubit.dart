import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_network/features/authentication/domain/usecase/login_usecase.dart';
import 'package:social_network/features/authentication/presentation/login/bloc/login_state.dart';

@injectable
class LogInCubit extends Cubit<LogInState> {
  LogInCubit({required LogInUseCase logInUseCase})
    : _logInUseCase = logInUseCase,
      super(const LogInInitialState());

  final LogInUseCase _logInUseCase;

  Future<void> logIn(LogInParam param) async {
    emit(LogInLoadingState());
    var result = await _logInUseCase.call(param);
    var newState = result.fold<LogInState>(
      (s) => LogInSuccessState(s),
      (f) => LogInFailureState(f.message),
    );
    emit(newState);
  }
}
