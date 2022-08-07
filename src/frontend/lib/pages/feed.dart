import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/widgets/homepage/widgets.dart';

class Feed extends ConsumerStatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  ConsumerState<Feed> createState() => _FeedState();
}

class _FeedState extends ConsumerState<Feed> {
  @override
  void initState() {
    super.initState();
    apiClient.fetch('posts/', 'GET', ref: ref).then((response) {
      if (response != null) {
        ref.read(postsFeedProvider.notifier).setData(response.data!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final postsFeed = ref.watch(postsFeedProvider);

    if (postsFeed.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      itemCount: postsFeed['results'].length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final post = Post.fromMap(postsFeed['results'][index]);
        return PostPreview(post);
      },
    );
  }
}
