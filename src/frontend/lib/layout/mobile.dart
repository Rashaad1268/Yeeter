import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/pages.dart';
import '../utils/utils.dart';
import '../widgets/homepage/widgets.dart';
import '../widgets/public/user_profile/user_profile_w_posts.dart';

class MobileLayout extends ConsumerWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create-post');
          },
          child: const FaIcon(FontAwesomeIcons.pencil)),
      body: IndexedStack(
          index: ref.watch(applicationStateProvider)['navbarIndex'],
          children: [
            const Feed(),
            const MessagesPage(),
            UserProfileWithPosts(
              ref.watch(userDataProvider)!,
              includeAppBar: false,
            ),
          ]),
    );
  }
}
