import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';

class MobileNavbar extends ConsumerWidget {
  final int index;
  const MobileNavbar(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (index) {
        ref.read(applicationStateProvider.notifier).setNavbarIndex(index);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.mail_rounded), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
