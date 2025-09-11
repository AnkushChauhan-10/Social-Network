import 'package:injectable/injectable.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/core/utils/use_case.dart';
import 'package:social_network/features/user/domain/entities/user.dart';
import 'package:social_network/features/user/domain/repository/account_picker_repo.dart';

@injectable
class GetAccountsUseCase extends UseCaseWithOutParam<Result<List<User>>> {
  const GetAccountsUseCase({required AccountPickerRepo accountPickerRepo})
    : _accountPickerRepo = accountPickerRepo;

  final AccountPickerRepo _accountPickerRepo;

  @override
  Result<List<User>> call() {
    var getUserList = _accountPickerRepo.getAccounts();
    return getUserList;
  }
}
