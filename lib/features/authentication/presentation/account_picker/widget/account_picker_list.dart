import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_cubit.dart';
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_state.dart';
import 'package:social_network/features/authentication/presentation/account_picker/widget/account_picker_list_tile.dart';

class AccountPickerList extends StatelessWidget {
  const AccountPickerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountPickerCubit, AccountPickerState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        return Container(
          color: Colors.transparent,
          constraints: BoxConstraints(maxHeight: 300),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: state.list.length,
            padding: EdgeInsets.symmetric(horizontal: AppSizes.xl),
            itemBuilder: (context, index) {
              final account = state.list[index];
              return AccountPickerListTile(account);
            },
          ),
        );
      },
    );
  }

  bool _buildWhen(AccountPickerState prev, AccountPickerState curr) {
    return prev is! AccountPickerInitial && curr is AccountPickerInitial;
  }
}
