import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/widgets/public/widgets.dart';

class UserProfileWithPosts extends ConsumerWidget {
  final User user;
  final bool includeAppBar;
  const UserProfileWithPosts(this.user, {Key? key, required this.includeAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        itemCount: 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                UserProfile(user),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text('Yeets',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
                const Divider(),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
