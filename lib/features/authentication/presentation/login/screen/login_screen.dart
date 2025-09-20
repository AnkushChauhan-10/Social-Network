import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/common_button.dart';
import 'package:social_network/core/widget/common_text_field.dart';
import 'package:social_network/core/widget/loading_dialog.dart';
import 'package:social_network/core/widget/logo_text.dart';
import 'package:social_network/features/authentication/domain/usecase/login_usecase.dart';
import 'package:social_network/features/authentication/presentation/login/bloc/login_cubit.dart';
import 'package:social_network/features/authentication/presentation/login/bloc/login_state.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  late final TapGestureRecognizer _signUpRecognizer;

  late final LogInCubit _logInCubit;

  @override
  void initState() {
    super.initState();
    _logInCubit = context.read<LogInCubit>();
    _formKey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        AppRouter.push(AppRoutes.signUp);
      };
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
  }

  void _listener(BuildContext context, LogInState state) {
    if (state is LogInSuccessState) AppRouter.go(AppRoutes.auth);
    if (state is LogInLoadingState) {
      TransparentLoadingDialog.show(context);
    } else {
      TransparentLoadingDialog.hide(context);
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      var param = LogInParam(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _logInCubit.logIn(param);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<LogInCubit, LogInState>(
        listener: _listener,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.xl),
            child: Form(
              key: _formKey, // assign key
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 86),
                  LogoText(),
                  const SizedBox(height: AppSizes.xxl),
                  CommonTextField(
                    controller: _emailController,
                    hintText: 'email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) return 'Enter valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.md),
                  CommonTextField(
                    controller: _passwordController,
                    hintText: 'password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password required';
                      }
                      if (value.length < 6) return 'Password too short';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.lg),
                  BlocBuilder<LogInCubit, LogInState>(
                    builder: (context, state) {
                      return SubmitButton(
                        text: "Login",
                        isLoading: state is LogInLoadingState,
                        onSubmit: _submit,
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.xxl),
                  RichText(
                    text: TextSpan(
                      text: "Do not any have account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: Theme.of(context).textTheme.labelLarge,
                          recognizer: _signUpRecognizer,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
