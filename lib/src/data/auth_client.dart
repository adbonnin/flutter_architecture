import 'package:flutter_riverpod/flutter_riverpod.dart';

final authClientProvider = Provider<AuthClient>((ref) => //
    AuthClient());

class AuthClient {
  Future<AuthResponse> auth(String username, String password) async {
    print('authentication');

    return AuthResponse(
      auth: true,
      token: 'fghsgfsgyfgsf',
    );
  }
}

class AuthResponse {
  AuthResponse({
    required this.auth,
    required this.token,
  });

  bool auth;
  String token;
}
