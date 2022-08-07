import 'package:flutter/material.dart';
import 'package:frontend/utils/utils.dart';

import '../../../models/user.dart';

class UserProfile extends StatelessWidget {
  final User user;
  const UserProfile(this.user, {Key? key}) : super(key: key);

  Widget getAboutMe(BuildContext context, double paddingTop) {
    if (user.profile.aboutMe?.isNotEmpty == true) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(top: paddingTop, left: 20),
            child: Text((user.profile.aboutMe).toString())),
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
    double bannerHeight = MediaQuery.of(context).size.height * 0.2;
    double profilePicDiameter = 150;
    TextStyle? follingTextStyle = Theme.of(context).textTheme.labelLarge;

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
                padding: EdgeInsets.only(top: bannerHeight, right: 8),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(shadowColor: Colors.blue),
                    onPressed: () {
                      // TODO: IMPLEMENT FOLLOWING
                      print('Follow button clicked');
                    },
                    child: const Text('Follow')),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: profilePicDiameter / 3, left: 20),
                child: Text(user.username,
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
                child: Text('@${user.handle}'),
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
                style: follingTextStyle!,
                child: Row(
                  children: [
                    Text(user.followersCount.toString(),
                        style: Theme.of(context).textTheme.titleMedium),
                    const Text(' Followers'),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(user.followingCount.toString(),
                        style: Theme.of(context).textTheme.titleMedium),
                    const Text(' Following'),
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
