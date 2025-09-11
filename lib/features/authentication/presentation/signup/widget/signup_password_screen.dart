import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/common_button.dart';
import 'package:social_network/core/widget/common_text_field.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_cubit.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_state.dart';

class SignUpPasswordScreen extends StatelessWidget {
  SignUpPasswordScreen({super.key});

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Create password",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          "Create a password comprising a minimum of 6 letters or digits.Ensure it's somthing that would be challenging for others to predict.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: AppSizes.lg),

        Form(
          key: _formKey,
          child: CommonTextField(
            controller: _passwordController
              ..text = _passwordText(context.read<SignUpCubit>().state),
            hintText: 'password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password required';
              }
              if (value.length < 6) return 'Password too short';
              return null;
            },
          ),
        ),
        const SizedBox(height: AppSizes.lg),
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (prev, curr) => curr is SignUpPassword,
          builder: (BuildContext context, SignUpState state) {
            return SubmitButton(
              text: "Next",
              isLoading: state is SignUpPasswordLoading,
              onSubmit: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpCubit>().submitPassword(
                    _passwordController.text,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  String _passwordText(SignUpState state) {
    if (state is SignUpPasswordCompleted) return state.password;
    return "";
  }
}
