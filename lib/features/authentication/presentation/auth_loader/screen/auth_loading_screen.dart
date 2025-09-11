import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/features/authentication/presentation/auth_loader/bloc/auth_cubit.dart';
import 'package:social_network/features/authentication/presentation/auth_loader/bloc/auth_state.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class AuthLoadingScreen extends StatefulWidget {
  const AuthLoadingScreen({super.key});

  @override
  State<AuthLoadingScreen> createState() => _AuthLoadingScreenState();
}

class _AuthLoadingScreenState extends State<AuthLoadingScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: _authListener,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    switch (state) {
      case AuthLoading():
      case Authenticated():
        AppRouter.go(AppRoutes.home);
      case Unauthenticated():
        AppRouter.go(AppRoutes.logIn);
      case ShowAccountPicker():
        AppRouter.go(AppRoutes.accountPicker,extra: state.accounts);
    }
  }
}
