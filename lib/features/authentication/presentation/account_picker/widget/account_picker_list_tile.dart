import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/circular_network_image.dart';
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_cubit.dart';
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_state.dart';
import 'package:social_network/features/user/domain/entities/user.dart';

class AccountPickerListTile extends StatelessWidget {
  const AccountPickerListTile(this.account, {super.key});

  final User account;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: ListTile(
        onTap: () => context.read<AccountPickerCubit>().logInWithUser(account),
        onLongPress: () async {
          var cubit = context.read<AccountPickerCubit>();
          var remove = await _showBottomSheet(context);
          if (remove) cubit.removeAccount(account);
        },
        leading: CircularNetworkImage(
          imageUrl: account.profilePicUrl,
          radius: 25,
        ),
        title: Text(
          account.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: BlocBuilder<AccountPickerCubit, AccountPickerState>(
          buildWhen: _loadingBuildCondition,
          builder: (context, state) {
            if (state is AccountPickerLoading && account == state.user) {
              return CircularProgressIndicator();
            }
            return const Icon(Icons.arrow_forward_ios, size: AppSizes.md);
          },
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        tileColor: Theme.of(context).inputDecorationTheme.fillColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          side: BorderSide(color: Theme.of(context).dividerColor, width: 0.2),
        ),
      ),
    );
  }

  Future<bool> _showBottomSheet(BuildContext context) async {
    final confirm = await showModalBottomSheet<bool>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.borderRadius),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Remove Account?",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 12),
              const Text("Are you sure you want to remove this account?"),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("Cancel",style: Theme.of(context).textTheme.bodyLarge,),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        "Delete",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return confirm ?? false;
  }

  bool _loadingBuildCondition(
    AccountPickerState prev,
    AccountPickerState curr,
  ) {
    if (prev is! AccountPickerLoading && curr is AccountPickerLoading) {
      return curr.user == account;
    }
    if (prev is AccountPickerLoading && curr is! AccountPickerLoading) {
      return prev.user == account;
    }
    return false;
  }
}
