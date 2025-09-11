import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/typedef.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/repository/account_picker_repo.dart';

@injectable
class RemoveUserUseCase extends UseCaseWithParam<FutureResult<void>, User> {
  const RemoveUserUseCase({required AccountPickerRepo accountPickerRepo})
    : _accountPickerRepo = accountPickerRepo;

  final AccountPickerRepo _accountPickerRepo;

  @override
  FutureResult<void> call(User param) async {
    return await _accountPickerRepo.removeUser(param);
  }
}
