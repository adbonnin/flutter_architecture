import 'package:flutter_architecture/src/data/auth_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthResponse>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthResponse> {
  AuthNotifier();

  @override
  AuthResponse build() {
    return AuthResponse(
      auth: false,
      token: '',
    );
  }

  Future<void> auth(String username, String password) async {
    final authClient = ref.read(authClientProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authClient.auth(username, password));
  }
}
