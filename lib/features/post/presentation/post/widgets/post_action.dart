import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  const PostActions({
    super.key,
    required this.isLiked,
    required this.likesCount,
    required this.commentsCount,
    required this.onLike,
    required this.onComment,
  });

  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final VoidCallback onLike;
  final VoidCallback onComment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          // Like button + count
          GestureDetector(
            onTap: onLike,
            child: Row(
              children: [
                Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                  size: 28,
                ),
                const SizedBox(width: 6),
                Text(
                  likesCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Comment button + count
          GestureDetector(
            onTap: onComment,
            child: Row(
              children: [
                const Icon(Icons.comment_outlined, size: 28),
                const SizedBox(width: 6),
                Text(
                  commentsCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Optional: share icon aligned to end
          // Spacer(),
          // IconButton(
          //   icon: const Icon(Icons.share_outlined),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
