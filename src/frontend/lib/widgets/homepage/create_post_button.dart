import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreatePostButton extends StatefulWidget {
  const CreatePostButton({Key? key}) : super(key: key);

  @override
  State<CreatePostButton> createState() => _CreatePostButtonState();
}

class _CreatePostButtonState extends State<CreatePostButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {}, child: const FaIcon(FontAwesomeIcons.pencil));
  }
}
