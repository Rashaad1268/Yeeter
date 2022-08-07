import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/pages.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/widgets/homepage/widgets.dart';

class DesktopLayout extends ConsumerStatefulWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends ConsumerState<DesktopLayout> {
  @override
  void initState() {
    super.initState();
    initializeData(ref);
  }

  @override
  Widget build(BuildContext context) {
    final applicationState = ref.watch(applicationStateProvider);

    if (!applicationState['isLoggedIn']) {
      return const LoginPage();
    }

    if (applicationState['isLoading']) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final userData = ref.watch(userDataProvider);
    return Scaffold(
      body: Row(
        children: [
          DesktopSidebar(width: MediaQuery.of(context).size.width / 4),
          Expanded(
            child: Builder(builder: (context) {
              if (applicationState['isLoggedIn']) {
                return Center(child: Text('Hello ${userData!.username}'));
              } else {
                return const Center(child: Text('you are **not** logged in'));
              }
            }),
          )
        ],
      ),
    );
  }
}
