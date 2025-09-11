import 'package:flutter/material.dart';
import 'package:social_network/core/constants/app_color.dart';
import 'package:social_network/core/constants/app_size.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.text,
    required this.isLoading,
    super.key,
    required this.onSubmit,
  });

  final String text;
  final bool isLoading;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: AbsorbPointer(
        absorbing: isLoading,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            ),
          ),
          onPressed: () {
            onSubmit.call();
          },
          child: isLoading
              ? CircularProgressIndicator(color: AppColors.lightBackground)
              : Text(text, style: TextStyle(color: AppColors.lightBackground)),
        ),
      ),
    );
  }
}
