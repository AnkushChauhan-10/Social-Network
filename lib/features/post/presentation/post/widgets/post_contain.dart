import 'package:flutter/material.dart';

class PostContent extends StatefulWidget {
  const PostContent({super.key, required this.username, required this.content});

  final String username;
  final String content;

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // TextSpan for rich text (username bold + content normal)
    final text = TextSpan(
      children: [
        TextSpan(
          text: '${widget.username} ',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextSpan(
          text: widget.content,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Measure if the text exceeds 2 lines
        final span = TextPainter(
          maxLines: 2,
          text: text,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflow = span.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: text,
              maxLines: _isExpanded ? null : 2,
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            if (isOverflow)
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    _isExpanded ? 'less' : 'more',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
