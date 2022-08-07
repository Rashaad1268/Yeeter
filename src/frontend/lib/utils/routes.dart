import 'package:flutter/material.dart';
import 'package:frontend/layout/layouts.dart';
import 'package:frontend/pages/pages.dart';

import '../widgets/widgets.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const Responsive(
        smallScreen: MobileLayout(),
        mediumScreen: MobileLayout(),
        largeScreen: DesktopLayout(),
      ),
  '/signup': (context) => const SignupPage(),
};

Route? onGenerateRoute(RouteSettings settings) {
  final List<String> pathElements = settings.name!.split('/');
  if (pathElements[0] != '' || pathElements.length == 1) {
    return null;
  }
  return null;
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
