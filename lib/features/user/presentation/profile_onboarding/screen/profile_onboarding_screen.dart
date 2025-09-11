import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/widget/loading_dialog.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/bloc/profile_onboarding_cubit.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/bloc/profile_onboarding_state.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/widgets/adding_profile_pic_screen.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/widgets/show_profile_pic_screen.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/widgets/welcom_user_screen.dart';

class ProfileOnboardingScreen extends StatelessWidget {
  const ProfileOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      resizeToAvoidBottomInset: false,
      body: BlocListener<ProfileOnBoardingCubit, ProfileOnBoardingState>(
        listener: (BuildContext context, state) {
          if (state is AddingProfilePicLoading) {
            LoadingDialog.show(context);
          } else {
            LoadingDialog.hide(context);
          }
          if (state is AddingProfilePicError) {
            showErrorDialog(context, title: "Error", message: state.message);
          }
        },
        child: BlocBuilder<ProfileOnBoardingCubit, ProfileOnBoardingState>(
          buildWhen: (old, curr) {
            if (curr is AddingProfilePicLoading ||
                curr is AddingProfilePicError) {
              return false;
            }
            return true;
          },
          builder: (BuildContext context, ProfileOnBoardingState state) {
            return switch (state) {
              AddingProfilePic() => AddingProfilePicScreen(),
              ShowProfilePic() => ShowProfilePicScreen(),
              WelcomeUser() => WelcomeUserScreen(state: state),
            };
          },
        ),
      ),
    );
  }

  Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
