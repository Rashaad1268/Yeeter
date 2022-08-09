import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/layout/layouts.dart';
import 'package:frontend/pages/pages.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/widgets/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    apiClient.fetch('auth/users/me/', 'GET', ref: ref).then((response) {
      if (isResponseOk(response) == true) {
        ref.read(userDataProvider.notifier).setData(response!.data['user']!);
        ref.read(applicationStateProvider.notifier).setIsLoading(false);
      }
    });
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

    return const Responsive(
      smallScreen: MobileLayout(),
      mediumScreen: MobileLayout(),
      largeScreen: MobileLayout(),
    );
  }
}
