import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/pages.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/widgets/homepage/widgets.dart';

class DesktopLayout extends ConsumerWidget {
  const DesktopLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userData = ref.watch(userDataProvider);
    return Scaffold(
      body: Row(
        children: [
          DesktopSidebar(width: MediaQuery.of(context).size.width / 4),
          Expanded(
            child: Builder(builder: (context) {
                return Center(child: Text('Hello ${userData!.username}'));
            }),
          )
        ],
      ),
    );
  }
}
