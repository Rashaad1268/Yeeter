import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/utils.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void attemptLogin() async {
    final response = await apiClient.fetch('auth/login/', 'POST',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
        ref: ref);

    if (isResponseOk(response) == true) {
      ref.read(userDataProvider.notifier).setData(response?.data['user']);
      ref.read(applicationStateProvider.notifier).setIsLoggedIn(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(children: [
            Text('Login', style: Theme.of(context).textTheme.headline3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text('Signup',
                          style: TextStyle(color: Colors.blue)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                validator: validateEmail,
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                validator: validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.indigo),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    attemptLogin();
                  }
                },
                child: const Text('Login'))
          ]),
        ),
      ),
    );
  }
}

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final handleController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  void attemptSignup() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(children: [
            Text('Welcome aboard!',
                style: Theme.of(context).textTheme.headline3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Login',
                          style: TextStyle(color: Colors.blue)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: usernameController,
                validator: validateUsername,
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                validator: validateEmail,
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: handleController,
                decoration: const InputDecoration(
                  labelText: 'Handle',
                  border: OutlineInputBorder(),
                ),
                validator: validateHandle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: password1Controller,
                validator: validatePassword,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Password 1',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: password2Controller,
                validator: (pswd2) {
                  if (password1Controller.text != pswd2) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Password 2',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.indigo),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    attemptSignup();
                  }
                },
                child: const Text('Signup'))
          ]),
        ),
      ),
    );
  }
}
