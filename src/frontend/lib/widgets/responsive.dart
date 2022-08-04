import 'package:flutter/material.dart';


class Responsive extends StatelessWidget {
  final Widget smallScreen;
  final Widget mediumScreen;
  final Widget largeScreen;

  const Responsive({
    Key? key,
    required this.smallScreen,
    required this.mediumScreen,
    required this.largeScreen,
  }) : super(key: key);

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a large screen
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return largeScreen;
        }
        // If width it less then 1100 and more then 650 we consider it as medium size screen
        else if (constraints.maxWidth >= 650) {
          return mediumScreen;
        }
        // Or less then that we call it a small screen
        else {
          return smallScreen;
        }
      },
    );
  }
}
