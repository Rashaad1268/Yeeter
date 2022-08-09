import 'package:flutter/material.dart';
import '../models/user.dart';


Widget getProfilePic(User user, BuildContext context, double radius) {
  bool hasProfilePic = user.profile.profilePicture != null;

  return CircleAvatar(
      radius: radius,
      backgroundImage:
          hasProfilePic ? NetworkImage(user.profile.profilePicture!) : null,
      backgroundColor: !hasProfilePic ? Colors.brown : null,
      child: !hasProfilePic
          ? Text(user.username[0], style: Theme.of(context).textTheme.headline5)
          : null);
}
