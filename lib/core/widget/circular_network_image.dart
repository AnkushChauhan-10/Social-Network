import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final BoxBorder? border;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double fitScale;
  final VoidCallback? onTap;

  const CircularNetworkImage({
    super.key,
    required this.imageUrl,
    this.radius = 24.0,
    this.border,
    this.placeholder,
    this.errorWidget,
    this.fitScale = 1.0,
    this.onTap,
  });

  Widget _defaultPlaceholder() {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: radius,
        height: radius,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _defaultError() {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: radius,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Container clipped(Widget child) => Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border,
      ),
      child: ClipOval(child: child),
    );

    // Empty or invalid URL -> show fallback
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      final fallback = errorWidget ?? _defaultError();
      return GestureDetector(onTap: onTap, child: fallback);
    }

    // Use cached network image
    final widget = CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              scale: fitScale,
            ),
            border: border,
          ),
        );
      },
      placeholder: (context, url) =>
      placeholder ?? _defaultPlaceholder(),
      errorWidget: (context, url, error) =>
      errorWidget ?? _defaultError(),
    );

    return GestureDetector(
      onTap: onTap,
      child: widget,
    );
  }
}