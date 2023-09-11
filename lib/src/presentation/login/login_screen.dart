import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/application/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider).auth;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(auth ? 'auth' : 'non auth'),
            ElevatedButton(
              onPressed: () => _onSignInPressed(ref),
              child: const Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignInPressed(WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    authNotifier.auth('test', 'test');
  }
}
