import 'package:flutter/material.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/circular_network_image.dart';
import 'package:social_network/core/widget/common_button.dart';
import 'package:social_network/core/widget/logo_text.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/bloc/profile_onboarding_state.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class WelcomeUserScreen extends StatelessWidget {
  const WelcomeUserScreen({super.key, required this.state});

  final WelcomeUser state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppSizes.xxl),
          LogoText(),
          const SizedBox(height: AppSizes.largerXXL),
          CircularNetworkImage(
            imageUrl: state.user.profilePicUrl,
            radius: 80,
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          const SizedBox(height: AppSizes.lg),
          Text(
            "Welcome to Social Network,",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            state.user.name,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Spacer(),
          SubmitButton(
            text: "Continue",
            isLoading: false,
            onSubmit: () {
              AppRouter.go(AppRoutes.home);
            },
          ),
          const SizedBox(height: AppSizes.xl),
        ],
      ),
    );
  }
}
