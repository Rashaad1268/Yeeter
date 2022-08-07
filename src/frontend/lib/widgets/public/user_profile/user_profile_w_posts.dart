import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/widgets/public/widgets.dart';

class UserProfileWithPosts extends StatefulWidget {
  final User user;
  const UserProfileWithPosts(this.user, {Key? key}) : super(key: key);

  @override
  State<UserProfileWithPosts> createState() => _UserProfileWithPostsState();
}

class _UserProfileWithPostsState extends State<UserProfileWithPosts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              UserProfile(widget.user),
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
    );
  }
}
