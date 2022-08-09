import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/utils/utils.dart';

import '../models/post.dart';
import '../utils/validators.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  final Post? quoting;
  const CreatePostPage({Key? key, this.quoting}) : super(key: key);

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController postBodyController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    postBodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create a Yeet')),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading:
                      getProfilePic(ref.watch(userDataProvider)!, context, 30),
                  title: TextFormField(
                    maxLines: 6,
                    controller: postBodyController,
                    validator: postBodyValidator,
                    decoration: const InputDecoration(
                      hintText: "What's on your mind?",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            apiClient
                                .fetch('/posts/', 'POST',
                                    data: {
                                      'body': postBodyController.text,
                                      'quoting': widget.quoting?.id,
                                    },
                                    ref: ref)
                                .then((response) {
                              if (isResponseOk(response) == true) {
                                ref
                                    .read(postsFeedProvider.notifier)
                                    .addPost(response?.data, first: true);
                              }
                              showApiErrors(context, response);
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('Create'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
