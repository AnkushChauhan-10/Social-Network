import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/cubit/media_picker/media_picker_cubit.dart';
import 'package:social_network/core/cubit/media_picker/media_picker_state.dart';
import 'package:social_network/core/di/injection.dart';

class MediaPickerWidget extends StatelessWidget {
  final Widget Function()? initialBuilder;
  final Widget Function()? loadingBuilder;
  final Widget Function(File file, bool isVideo, VoidCallback onClear)?
  pickedBuilder;
  final Widget Function(String error)? errorBuilder;

  final void Function(File file, bool isVideo)? onPicked;
  final void Function(String error)? onError;

  const MediaPickerWidget({
    super.key,
    this.initialBuilder,
    this.loadingBuilder,
    this.pickedBuilder,
    this.errorBuilder,
    this.onPicked,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => getIt<MediaPickerCubit>(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<MediaPickerCubit, MediaPickerState>(
            listener: (context, state) {
              if (state is MediaPickerPicked) {
                onPicked?.call(state.file, state.isVideo);
              } else if (state is MediaPickerError) {
                onError?.call(state.message);
              }
            },
            builder: (context, state) {
              return switch (state) {
                MediaPickerInitial() =>
                  initialBuilder?.call() ??
                      ElevatedButton(
                        onPressed: () =>
                            context.read<MediaPickerCubit>().pickImage(),
                        child: const Text("Pick Image"),
                      ),
                MediaPickerLoading() =>
                  loadingBuilder?.call() ??
                      const Center(child: CircularProgressIndicator()),
                MediaPickerPicked(:final file, :final isVideo) =>
                  pickedBuilder?.call(file, isVideo, () {
                        context.read<MediaPickerCubit>().clear();
                      }) ??
                      Stack(
                        children: [
                          isVideo
                              ? const Icon(Icons.videocam, size: 100)
                              : Image.file(
                                  file,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: const Icon(Icons.clear, color: Colors.red),
                              onPressed: () =>
                                  context.read<MediaPickerCubit>().clear(),
                            ),
                          ),
                        ],
                      ),
                MediaPickerError(:final message) =>
                  errorBuilder?.call(message) ??
                      Column(
                        children: [
                          Text(
                            "Error: $message",
                            style: const TextStyle(color: Colors.red),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<MediaPickerCubit>().pickImage(),
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
              };
            },
          );
        },
      ),
    );
  }
}
