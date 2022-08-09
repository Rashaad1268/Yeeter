import 'package:flutter/material.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/homepage.dart';
import 'package:frontend/pages/pages.dart';
import 'package:frontend/widgets/public/widgets.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const HomePage(),
  '/signup': (context) => const SignupPage(),
};

Route? onGenerateRoute(RouteSettings settings) {
  final pathItems = settings.name!
      .split('/'); // to seperate the url arguments from the actual endpoint

  Widget? page;
  bool fullScreenDialog = false;

  switch (pathItems[1]) {
    case 'create-post':
      page = CreatePostPage(quoting: settings.arguments as Post?);
      fullScreenDialog = true;
      break;

    case 'post':
      page = PostDetail(settings.arguments as Post);
      break;

    case 'user':
      page = UserProfileWithPosts(
        settings.arguments as User,
        includeAppBar: true,
      );
      break;
  }
  if (page != null) {
    return MaterialPageRoute(
        builder: (context) => page!, fullscreenDialog: fullScreenDialog);
  } else {
    return onUnknownRoute(settings);
  }
}

Route onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text(
          settings.name!.split('/')[1],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('${settings.name!.split('/')[1]} Not found'),
      ),
    ),
  );
}
