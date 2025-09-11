import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/di/injection.dart';
import 'package:social_network/features/authentication/domain/usecase/log_out_usecase.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(this.shell, {super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shell.currentIndex,
        onTap: shell.goBranch,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home2"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home3"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async{
          var logOut = getIt.call<LogOutUseCase>();
          await logOut.call();
          AppRouter.push(AppRoutes.auth);
          // AppRouter.push(AppRoutes.createPost);
        },
      ),
    );
  }
}
