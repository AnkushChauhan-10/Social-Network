import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_color.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/cubit/media_picker/media_picker_cubit.dart';
import 'package:social_network/core/widget/media_picker_widget.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/bloc/profile_onboarding_cubit.dart';

class AddingProfilePicScreen extends StatelessWidget {
  const AddingProfilePicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSizes.xxl),
          Text(
            "Add a profile picture",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            "Let's add a profile picture so your friends can easily recognize you. Your picture will be visible to everyone.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSizes.largerXXL),
          Container(
            padding: EdgeInsets.all(AppSizes.xs),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.person,
                size: 90,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Spacer(),
          MediaPickerWidget(
            initialBuilder: () {
              return Builder(
                builder: (context) {
                  return ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: AppColors.lightBackground,
                          size: AppSizes.lg,
                        ),
                        const SizedBox(width: AppSizes.sm),
                        Text(
                          "Add picture",
                          style: TextStyle(color: AppColors.lightBackground),
                        ),
                      ],
                    ),
                    onPressed: () {
                      context.read<MediaPickerCubit>().pickImage();
                    },
                  );
                }
              );
            },
            pickedBuilder: (f,v,c)=>SizedBox.shrink(),
            onPicked: (file,isVideo){
              context.read<ProfileOnBoardingCubit>().addProfilePic(file);
            },
          ),
          const SizedBox(height: AppSizes.md),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                side: BorderSide(color: AppColors.primaryBlue),
              ),
            ),
            child: Text(
              "Skip",
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              context.read<ProfileOnBoardingCubit>().skipProfilePic();
            },
          ),
          const SizedBox(height: AppSizes.xl),
        ],
      ),
    );
  }
}
