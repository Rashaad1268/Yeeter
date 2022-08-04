import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/layout/layouts.dart';
import 'package:frontend/pages/authentication.dart';
import 'package:frontend/widgets/widgets.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yeeter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => const Responsive(
              smallScreen: MobileLayout(),
              mediumScreen: DesktopLayout(),
              largeScreen: DesktopLayout(),
            ),
        '/signup': (context) => const SignupPage(),
      },
    );
  }
}
