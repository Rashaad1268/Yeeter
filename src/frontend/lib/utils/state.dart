import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants.dart';

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, ApiObject>((ref) {
  return UserDataNotifier();
});

final applicationStateProvider =
    StateNotifierProvider<ApplicationStateStateNotifier, ApiObject>((ref) {
  return ApplicationStateStateNotifier();
});

class UserDataNotifier extends StateNotifier<ApiObject> {
  UserDataNotifier() : super({'profile': {}});

  void setData(ApiObject newData) => state = newData;
}

class ApplicationStateStateNotifier extends StateNotifier<ApiObject> {
  ApplicationStateStateNotifier()
      : super({'isLoggedIn': true, 'isLoading': true});
  setData(ApiObject data) => state = data;
  setIsLoggedIn(bool loggedInStatus) =>
      state = {...state, 'isLoggedIn': loggedInStatus};
  setIsLoading(bool loadingStatus) =>
      state = {...state, 'isLoading': loadingStatus};
}
