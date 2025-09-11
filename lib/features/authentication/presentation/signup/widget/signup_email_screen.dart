import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/common_button.dart';
import 'package:social_network/core/widget/common_text_field.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_cubit.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_state.dart';

class SignupEmailScreen extends StatelessWidget {
  SignupEmailScreen({super.key});

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "What's your email?",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          "Enter the email where you can be contacted.No one will see this on your profile.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: AppSizes.lg),

        Form(
          key: _formKey,
          child: CommonTextField(
            controller: _emailController
              ..text = _emailText(context.read<SignUpCubit>().state),
            hintText: 'email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!value.contains('@')) return 'Enter valid email';
              return null;
            },
          ),
        ),
        const SizedBox(height: AppSizes.lg),
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (prev, curr) => curr is SignUpEmail,
          builder: (BuildContext context, SignUpState state) {
            return SubmitButton(
              text: "Next",
              isLoading: state is SignUpEmailLoading,
              onSubmit: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpCubit>().submitEmail(
                    _emailController.text,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  String _emailText(SignUpState state) {
    if (state is SignUpEmailCompleted) return state.email;
    return "";
  }
}
