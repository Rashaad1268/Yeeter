import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/widgets/public/user_profile/user_profile_w_posts.dart';

import '../pages/pages.dart';
import '../utils/utils.dart';
import '../widgets/homepage/widgets.dart';

class MobileLayout extends ConsumerStatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends ConsumerState<MobileLayout> {
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

    final user = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeeter'),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        leading: getProfilePic(user!, context, 20),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar:
          MobileNavbar(ref.read(applicationStateProvider)['navbarIndex']),
      floatingActionButton: const CreatePostButton(),
      body: IndexedStack(
          index: ref.read(applicationStateProvider)['navbarIndex'],
          children: [
            const Feed(),
            const MessagesPage(),
            UserProfileWithPosts(ref.watch(userDataProvider)!),
          ]),
    );
  }
}
