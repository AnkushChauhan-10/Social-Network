import 'package:flutter/material.dart';
import 'package:social_network/core/di/injection.dart';
import 'package:social_network/core/utils/result.dart';
import 'package:social_network/features/session/domain/usecase/check_session_usecase.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setTimer();
  }

  void setTimer() async {
    await Future.delayed(Duration(seconds: 3));
    AppRouter.go(AppRoutes.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [FlutterLogo(size: 100)],
        ),
      ),
    );
  }
}
