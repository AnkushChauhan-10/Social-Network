import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/common_button.dart';
import 'package:social_network/core/widget/common_text_field.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_cubit.dart';
import 'package:social_network/features/authentication/presentation/signup/bloc/signup_state.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class SignUpCreateUserScreen extends StatelessWidget {
  SignUpCreateUserScreen({super.key});

  final _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "What's your name?",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          "Add your name so friends can find you.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: AppSizes.lg),

        Form(
          key: _formKey,
          child: CommonTextField(
            controller: _nameController,
            hintText: 'Full name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: AppSizes.lg),
        BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (prev,curr)=>curr is SignUpCreateUser,
          listener: (context,state){
            if(state is SignUpCreateUserSuccess) AppRouter.go(AppRoutes.profileOnBoarding);
          },
          child: BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (prev, curr) => curr is SignUpCreateUser,
            builder: (BuildContext context, SignUpState state) {
              return SubmitButton(
                text: "Next",
                isLoading: state is SignUpCreateUserLoading,
                onSubmit: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpCubit>().createUser(_nameController.text);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
