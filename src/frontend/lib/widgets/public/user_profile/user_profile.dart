import 'package:flutter/material.dart';
import 'package:frontend/utils/utils.dart';

import '../../../models/user.dart';

export './user_profile_w_posts.dart';

class UserProfile extends StatelessWidget {
  final User user;
  const UserProfile(this.user, {Key? key}) : super(key: key);

  Widget getAboutMe(BuildContext context, double paddingTop) {
    if (user.profile.aboutMe?.isNotEmpty == true) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(top: paddingTop, left: 20),
            child: SelectableText((user.profile.aboutMe).toString())),
      );
    }
    return const SizedBox();
  }

  Widget getBannerImage(BuildContext context, double bannerHeight) {
    if (user.profile.bannerImage != null) {
      return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4)),
        ),
        child: Image.network(user.profile.bannerImage!,
            height: bannerHeight, width: double.infinity, fit: BoxFit.fitWidth),
      );
    } else {
      return Container(
        height: bannerHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.grey, border: Border(bottom: BorderSide(width: 0.3))),
        child: Center(
          child:
              Text('No banner', style: Theme.of(context).textTheme.headline4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double bannerHeight = MediaQuery.of(context).size.height / 4;
    double profilePicDiameter = 150;
    final follingTextStyle = Theme.of(context).textTheme.labelLarge!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        getBannerImage(context, bannerHeight),
        Positioned(
          top: bannerHeight - (profilePicDiameter / 2),
          child: Padding(
            padding: EdgeInsets.only(left: 8, bottom: profilePicDiameter / 2),
            child: getProfilePic(user, context, profilePicDiameter / 2),
          ),
        ),
        // IDK why the OutlinedButton won't work
        // without the Column
        Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(top: bannerHeight - 45, right: 8),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        icon: const Icon(Icons.edit)),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary:
                                user.isFollowing ? Colors.red : Colors.blue),
                        onPressed: () {
                          // TODO: IMPLEMENT FOLLOWING
                          print('Follow button clicked');
                        },
                        child: user.isFollowing
                            ? const Text('Unfollow')
                            : const Text('Follow')),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: profilePicDiameter / 3, left: 20),
                child: SelectableText(user.username,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SelectableText('@${user.handle}'),
              ),
            ),
            if (user.isStaff)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 7, left: 20),
                  child: Text('Staff',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            getAboutMe(context, 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 12),
              child: DefaultTextStyle(
                style: follingTextStyle,
                child: Row(
                  children: [
                    SelectableText(user.followersCount.toString(),
                        style: Theme.of(context).textTheme.titleMedium),
                    const SelectableText(' Followers'),
                    const SizedBox(
                      width: 15,
                    ),
                    SelectableText(user.followingCount.toString(),
                        style: Theme.of(context).textTheme.titleMedium),
                    const SelectableText(' Following'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
