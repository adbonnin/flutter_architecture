import 'package:flutter_architecture/src/data/auth_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  AuthNotifier();

  @override
  Future<AuthResponse> build() {
    return Future.value(
      AuthResponse(
        auth: false,
        token: '',
      ),
    );
  }

  Future<void> auth(String username, String password) async {
    final authClient = ref.read(authClientProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authClient.auth(username, password));
  }
}
