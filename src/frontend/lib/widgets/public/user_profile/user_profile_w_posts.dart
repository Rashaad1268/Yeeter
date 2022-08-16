import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/widgets/public/widgets.dart';

import '../../homepage/widgets.dart';

class UserProfileWithPosts extends ConsumerWidget {
  final User user;
  final bool includeAppBar;
  const UserProfileWithPosts(this.user, {Key? key, required this.includeAppBar})
      : super(key: key);

  void fetchPosts(WidgetRef ref) async {
    final response =
        await apiClient.fetch('posts/?author=${user.id}', 'GET', ref: ref);
    if (isResponseOk(response) == true) {
      ref
          .read(postsFromUserProvider.notifier)
          .setPostsForUser(user.id, response?.data);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersPosts = ref.watch(postsFromUserProvider)[user.id];

    if (usersPosts == null) {
      fetchPosts(ref);
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: includeAppBar
          ? AppBar(
              title: Row(
                children: [
                  Text(user.username),
                  const SizedBox(
                    width: 15,
                  ),
                  Text('@${user.handle}',
                      style: TextStyle(color: Colors.grey[300])),
                ],
              ),
              centerTitle: false,
            )
          : null,
      body: ListView.builder(
        itemCount: usersPosts['results'].length, // We don't need to add 1
        // since the length doesn't start from zero
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                UserProfile(user),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text("Yeets (${usersPosts['count']})",
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
                const Divider(),
              ],
            );
          } else {
            return PostPreview(Post.fromMap(usersPosts['results'][index]));
          }
        },
      ),
    );
  }
}
