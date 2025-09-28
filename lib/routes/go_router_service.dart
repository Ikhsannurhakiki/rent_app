import 'package:go_router/go_router.dart';
import 'package:rent_app/presentation/screens/home_screen.dart';

import '../presentation/provider/auth_provider.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/main_screen.dart';
import '../presentation/screens/register_screen.dart';
import '../presentation/screens/splash_screen.dart';

class GoRouterService {
  GoRouter get router => _router;
  final AuthProvider authProvider;

  GoRouterService(this.authProvider);

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: authProvider,
    redirect: (context, state) {
      final auth = authProvider;

      final isSplash = state.matchedLocation == '/';
      final isLogin = state.matchedLocation == '/login';
      final isRegister = state.matchedLocation == '/register';

      if (!auth.isInitialized) {
        return isSplash ? null : '/';
      }

      if (!auth.isLoggedIn && !isLogin && !isRegister) {
        return '/main';
      }

      if (auth.isLoggedIn && (isSplash || isLogin || isRegister)) {
        return '/main';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const MainScreen(),
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const HomeScreen(),
            routes: []
          ),
        ],
      ),
    ],
  );
}
