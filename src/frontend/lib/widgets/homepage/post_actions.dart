import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/post.dart';
import '../../utils/utils.dart';

class LikePostButton extends ConsumerStatefulWidget {
  final Post post;
  const LikePostButton(this.post, {Key? key}) : super(key: key);

  @override
  ConsumerState<LikePostButton> createState() => _LikePostButtonState();
}

class _LikePostButtonState extends ConsumerState<LikePostButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          focusColor: Colors.pink[100],
          onPressed: () async {
            final response = await apiClient
                .fetch('posts/${widget.post.id}/like/', 'POST', ref: ref);
            if (isResponseOk(response) == true) {
              setState(() {
                if (widget.post.isLiked) {
                  // Unlike the post if it's already liked
                  widget.post.likeCount--;
                } else {
                  // Like the post if it's not already liked
                  widget.post.likeCount++;
                }
                widget.post.isLiked = !widget.post.isLiked;
              });
            }
          },
          icon: Icon(
              widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
              color: widget.post.isLiked ? Colors.pink : Colors.grey),
        ),
        Text(widget.post.likeCount.toString(),
            style: TextStyle(color: Colors.grey[500])),
      ],
    );
  }
}

class RePostButton extends ConsumerWidget {
  final Post post;
  const RePostButton(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              apiClient
                  .fetch('/posts/${post.id}/re-post/', 'POST', ref: ref)
                  .then((response) {
                showApiErrors(context, response);
                if (isResponseOk(response) == true) {
                  ref
                      .read(postsFeedProvider.notifier)
                      .addPost(response!.data, first: true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Re-Yeet successful'),
                  ));
                }
              });
            },
            icon: const FaIcon(FontAwesomeIcons.retweet, color: Colors.grey)),
        Text(post.rePostCount.toString())
      ],
    );
  }
}
