import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/user.dart';

import 'constants.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier, User?>((ref) {
  return UserDataNotifier();
});

final applicationStateProvider =
    StateNotifierProvider<ApplicationStateStateNotifier, ApiObject>((ref) {
  return ApplicationStateStateNotifier();
});

final postsFeedProvider =
    StateNotifierProvider<PostsFeedNotifier, ApiObject>((ref) {
  return PostsFeedNotifier();
});

final postsFromUserProvider =
    StateNotifierProvider<PostsFromUserNotifier, Map<int, ApiObject>>((ref) {
  return PostsFromUserNotifier();
});

class UserDataNotifier extends StateNotifier<User?> {
  UserDataNotifier() : super(null);

  void setData(ApiObject newData) {
    state = User.fromMap(newData);
  }
}

class ApplicationStateStateNotifier extends StateNotifier<ApiObject> {
  ApplicationStateStateNotifier()
      : super({'isLoggedIn': true, 'isLoading': true, 'navbarIndex': 0});
  setData(ApiObject data) => state = data;
  setIsLoggedIn(bool loggedInStatus) =>
      state = {...state, 'isLoggedIn': loggedInStatus};
  setIsLoading(bool loadingStatus) =>
      state = {...state, 'isLoading': loadingStatus};
  setNavbarIndex(int index) => state = {...state, 'navbarIndex': index};
}

class PostsFeedNotifier extends StateNotifier<ApiObject> {
  PostsFeedNotifier() : super({});

  void setData(ApiObject newData) {
    state = newData;
  }

  void addPosts(ApiObject newPostsPaginator) {
    newPostsPaginator['results'] = [
      ...(state['results'] ?? []),
      ...newPostsPaginator['results']
    ];
    state = newPostsPaginator;
  }

  void addPost(ApiObject post, {required bool first}) {
    final newState = {...state};
    if (first) {
      newState['results'] = [post, ...(newState['results'] ?? [])];
    } else {
      newState['results'] = [...(newState['results'] ?? []), post];
    }
    state = newState;
  }
}

class PostsFromUserNotifier extends StateNotifier<Map<int, ApiObject>> {
  PostsFromUserNotifier() : super({});

  void setPostsForUser(int userId, ApiObject postsPaginator) {
    final newState = {...state};
    newState[userId] = postsPaginator;
    state = newState;
  }

  void addPostsForUser(int userId, ApiObject newPostsPaginator) {
    final newState = {...state};
    newPostsPaginator['results'] = [
      ...(newState[userId]!['results'] ?? []),
      ...newPostsPaginator['results']
    ];
    state = newState;
  }
}
