import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/utils/utils.dart';

import './post_actions.dart';

class PostPreview extends StatelessWidget {
  final Post post;
  const PostPreview(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post.rePost != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              const FaIcon(FontAwesomeIcons.retweet),
              const SizedBox(
                width: 8,
              ),
              Text('Re-Yeeted by ${post.author.username}')
            ],
          ),
          PostPreview(post.rePost!),
        ],
      );
    }
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
          SelectableText(post.body!,
              style: Theme.of(context).textTheme.bodyMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(FontAwesomeIcons.comment, color: Colors.grey[500]),
              RePostButton(post),
              LikePostButton(post),
            ],
          ),
        ],
      ),
    );
  }
}
