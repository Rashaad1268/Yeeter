import 'package:frontend/utils/constants.dart';

class _Profile {
  final String? aboutMe;
  final String? profilePicture;
  final String? bannerImage;
  _Profile({this.aboutMe, this.profilePicture, this.bannerImage});

  factory _Profile.fromMap(ApiObject data) {
    return _Profile(
        aboutMe: data['about_me'],
        profilePicture: data['profile_picture'],
        bannerImage: data['banner_image']);
  }
}

class User {
  final int id;
  final String username;
  final String handle;
  final bool isOnline;
  final bool isStaff;
  final int followersCount;
  final int followingCount;
  final bool isFollowing;
  final bool isFollowingMe;
  // ignore: library_private_types_in_public_api
  final _Profile profile;

  User(
      {required this.id,
      required this.username,
      required this.handle,
      required this.isOnline,
      required this.isStaff,
      required this.followersCount,
      required this.followingCount,
      required this.isFollowing,
      required this.isFollowingMe,
      // ignore: library_private_types_in_public_api
      required this.profile});

  factory User.fromMap(ApiObject data) {
    return User(
        id: data['id'],
        username: data['username'],
        handle: data['handle'],
        isOnline: data['is_online'],
        isStaff: data['is_staff'],
        followersCount: data['followers_count'],
        followingCount: data['following_count'],
        isFollowing: data['is_following'],
        isFollowingMe: data['is_following_me'],
        profile: _Profile.fromMap(data['profile']));
  }
}
