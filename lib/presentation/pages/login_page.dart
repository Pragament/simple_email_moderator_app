import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_email_moderator_app/logic/providers/user_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pragament Moderator'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset(
                'assets/logo.png',
                height: 250,
                width: 250,
              ),
            ),
          ),
          SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withAlpha(100),
                    borderRadius: BorderRadius.circular(18.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    label: const Text('Login'),
                    icon: Image.asset('assets/google.png', height: 20),
                    onPressed: () async =>
                    await ref.read(userProvider.notifier).login(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
