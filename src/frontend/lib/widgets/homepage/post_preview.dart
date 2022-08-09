import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/utils/utils.dart';

class PostPreview extends StatelessWidget {
  final Post post;
  const PostPreview(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/user/${post.author.id}',
                arguments: post.author);
          },
          child: getProfilePic(post.author, context, 20)),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SelectableText(post.author.username,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
            Text('@${post.author.handle} · ',
                style: TextStyle(color: Colors.grey[500])),
            Text(formatPostTimeStamp(DateTime.parse(post.createdAt)),
                style: TextStyle(color: Colors.grey[500])),
            if (post.editedAt != null)
              Tooltip(
                  message:
                      'Edited at: ${dtFormatWithTime.format(DateTime.parse(post.editedAt!))}',
                  child: Text(' (edited)',
                      style: TextStyle(color: Colors.grey[500]))),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(post.body,
              style: Theme.of(context).textTheme.bodyMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(FontAwesomeIcons.comment, color: Colors.grey[500]),
              FaIcon(FontAwesomeIcons.retweet, color: Colors.grey[500]),
              LikePostButton(post),
            ],
          ),
        ],
      ),
    );
  }
}

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
          onPressed: () async {
            final response = await apiClient
                .fetch('posts/${widget.post.id}/like/', 'POST', ref: ref);
            if (isResponseOk(response) == true) {
              setState(() {
                if (widget.post.isLiked) {
                  // Unliking the post
                  widget.post.likeCount--;
                } else {
                  // Liking the post
                  widget.post.likeCount++;
                }
                widget.post.isLiked = !widget.post.isLiked;
              });
            }
          },
          icon: Icon(
              widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
              color: widget.post.isLiked ? Colors.red : Colors.grey),
        ),
        Text(widget.post.likeCount.toString(),
            style: TextStyle(color: Colors.grey[500])),
      ],
    );
  }
}
