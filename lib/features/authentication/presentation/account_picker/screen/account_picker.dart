import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_color.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/loading_dialog.dart';
import 'package:social_network/core/widget/logo_text.dart';
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_cubit.dart';
import 'package:social_network/features/authentication/presentation/account_picker/bloc/account_picker_state.dart';
import 'package:social_network/features/authentication/presentation/account_picker/widget/account_picker_list.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class AccountPickerScreen extends StatelessWidget {
  const AccountPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.transparent,),
      body: BlocListener<AccountPickerCubit, AccountPickerState>(
        listener: _accountPickerListener,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 104),
              LogoText(),
              const SizedBox(height: AppSizes.xxl),

              const AccountPickerList(),

              const SizedBox(height: AppSizes.xxl),

              // Switch Account Text
              RichText(
                text: TextSpan(
                  text: 'Switch Account',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: AppFontSizes.xl,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => AppRouter.push(AppRoutes.logIn),
                ),
              ),
              Spacer(),
              Divider(height: AppSizes.xxl, thickness: 0.3),
              RichText(
                text: TextSpan(
                  text: "Do not any have account? ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: Theme.of(context).textTheme.bodyLarge,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppRouter.push(AppRoutes.signUp);
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.xl),
            ],
          ),
        ),
      ),
    );
  }

  void _accountPickerListener(BuildContext context, AccountPickerState state) {
    if (state is AccountPickerEmpty) AppRouter.go(AppRoutes.logIn);
    if (state is AccountPickerLoading) {
      TransparentLoadingDialog.show(context);
    } else {
      TransparentLoadingDialog.hide(context);
    }
    if (state is AccountPikerSelected) AppRouter.go(AppRoutes.auth);
  }
}
