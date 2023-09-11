import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/src/application/auth_providers.dart';
import 'package:flutter_architecture/src/presentation/home/home_screen.dart';
import 'package:flutter_architecture/src/presentation/login/login_screen.dart';
import 'package:flutter_architecture/src/presentation/profile/profile_screen.dart';
import 'package:flutter_architecture/src/presentation/todo_details/todo_details_screen.dart';
import 'package:flutter_architecture/src/presentation/todo_list/todo_list_screen.dart';
import 'package:flutter_architecture/src/router/shell_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');
final _todosNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

// https://github.com/flutter/flutter/issues/127371
final _routes = [
  GoRoute(
    path: '/login',
    builder: (_, __) => const LoginScreen(),
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, _, navigationShell) => ShellScaffold(
      navigationShell: navigationShell,
    ),
    branches: [
      StatefulShellBranch(
        navigatorKey: _homeNavigatorKey,
        routes: [
          GoRoute(
            path: '/home',
            builder: (_, state) => const HomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _todosNavigatorKey,
        routes: [
          GoRoute(
            path: '/todos',
            builder: (_, __) => const TodoListScreen(),
          ),
          GoRoute(
            path: '/todos/:id',
            builder: (_, state) {
              final id = int.parse(state.pathParameters['id']!);
              return TodoDetailsScreen(id: id);
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _profileNavigatorKey,
        routes: [
          GoRoute(
            path: '/profile',
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  )
];

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: _routes,
    debugLogDiagnostics: kDebugMode,
    redirect: (_, state) => _redirect(ref, state),
    navigatorKey: _rootNavigatorKey,
    refreshListenable: _RouterChangeNotifier(ref),
  );
});

String? _redirect(Ref ref, GoRouterState state) {
  final location = state.matchedLocation;
  final isAuth = ref.read(authProvider).auth;

  if (!isAuth) {
    return '/login';
  }

  if (location == '/login' && isAuth) {
    return '/home';
  }

  return null;
}

class _RouterChangeNotifier extends ChangeNotifier {
  _RouterChangeNotifier(Ref ref) {
    ref.listen(authProvider, (_, __) => notifyListeners());
  }
}
