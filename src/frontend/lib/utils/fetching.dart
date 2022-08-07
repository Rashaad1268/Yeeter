import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/utils/utils.dart';

import '../models/user.dart';

void initializeData(WidgetRef ref) {
  apiClient.fetch('auth/users/me/', 'GET', ref: ref).then((response) {
    if (isResponseOk(response) == true) {
      ref.read(userDataProvider.notifier).setData(response!.data['user']!);
      ref.read(applicationStateProvider.notifier).setIsLoading(false);
    }
  });
}

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
