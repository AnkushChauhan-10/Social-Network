import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/loading_dialog.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_cubit.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_state.dart';
import 'package:social_network/features/authentication/presentation/signup/widget/signup_email_screen.dart';
import 'package:social_network/features/authentication/presentation/signup/widget/signup_create_user_screen.dart';
import 'package:social_network/features/authentication/presentation/signup/widget/signup_password_screen.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/widgets/show_profile_pic_screen.dart';
import 'package:social_network/features/authentication/presentation/signup/widget/signup_user_name.dart';
import 'package:social_network/route/app_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: BlocListener<SignUpCubit,SignUpState>(
        listenWhen: (old, curr) =>
        (old is! Loading && curr is Loading) ||
            (old is Loading && curr is! Loading),
        listener: (BuildContext context, state) {
          if(state is Loading) {
            TransparentLoadingDialog.show(context);
          } else {
            TransparentLoadingDialog.hide(context);
          }
        },
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (b, d) {
            if (b) return;
            if (context.read<SignUpCubit>().onBack()) {
              AppRouter.pop();
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.md,
                    vertical: AppSizes.lg,
                  ),
                  child: BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (old, curr) {
                      if (curr is Loading || curr is Error) return false;
                      return true;
                    },
                    builder: (BuildContext context, SignUpState state) {
                      var screen = switch (state) {
                        SignUpEmail() => SignupEmailScreen(),
                        SignUpPassword() => SignUpPasswordScreen(),
                        SignUpUserName() => SignUpUserNameScreen(),
                        SignUpCreateUser() => SignUpCreateUserScreen(),
                      };
                      print("-$state == $screen-");
                      return screen;
                    },
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "Already have a account? ",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                  children: [
                    TextSpan(
                      text: "Log In",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppRouter.pop();
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
}
