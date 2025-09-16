import 'package:flutter/material.dart';
import 'package:social_network/features/post/presentation/feed_post/widget/feed_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: FeedList(),
    );
  }
}
