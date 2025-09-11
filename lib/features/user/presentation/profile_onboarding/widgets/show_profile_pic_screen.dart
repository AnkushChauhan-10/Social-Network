import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/core/widget/media_picker_widget.dart';
import 'package:social_network/features/user/presentation/profile_onboarding/bloc/profile_onboarding_cubit.dart';

class ShowProfilePicScreen extends StatefulWidget {
  const ShowProfilePicScreen({super.key});

  @override
  State<ShowProfilePicScreen> createState() => _ShowProfilePicScreenState();
}

class _ShowProfilePicScreenState extends State<ShowProfilePicScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Add a profile picture",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          "Let's add a profile picture so your friends can easily recognize you. Your picture will be visible to everyone.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSizes.sm),
        MediaPickerWidget(
          pickedBuilder: (file, isPicked, onClear) {
            return Stack(
              children: [
                CircleAvatar(radius: 120, backgroundImage: FileImage(file)),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.clear, size: 16, color: Colors.white),
                      onPressed: () => onClear.call(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ProfileOnBoardingCubit>().goToWelcome();
          },
          child: Text("Next"),
        ),
      ],
    );
  }
}
