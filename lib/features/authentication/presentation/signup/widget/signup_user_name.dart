import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/common_button.dart';
import 'package:social_network/core/widget/common_text_field.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_cubit.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_state.dart';

class SignUpUserNameScreen extends StatelessWidget {
  SignUpUserNameScreen({super.key});

  final _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Create a username",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          "Add a username or use our suggestion. You can change this at any time",
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: AppSizes.lg),

        Form(
          key: _formKey,
          child: CommonTextField(
            controller: _userNameController
              ..text = _userNameText(context.read<SignUpCubit>().state),
            hintText: 'User name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: AppSizes.lg),
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (prev, curr) => curr is SignUpUserName,
          builder: (BuildContext context, SignUpState state) {
            return SubmitButton(
              text: "Next",
              isLoading: state is SignUpUserNameLoading,
              onSubmit: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpCubit>().submitUserName(
                    _userNameController.text,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  String _userNameText(SignUpState state) {
    if (state is SignUpUserNameCompleted) return state.userName;
    return "";
  }
}
