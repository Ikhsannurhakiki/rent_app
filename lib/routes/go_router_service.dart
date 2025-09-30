import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/screens/login_screen.dart';
import 'package:rent_app/presentation/screens/main_screen.dart';
import 'package:rent_app/presentation/screens/splash_screen.dart';

import '../presentation/provider/auth_provider.dart';


class AppRouter {
  static GoRouter router(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return GoRouter(
      initialLocation: '/splash',
      refreshListenable: authProvider,
      redirect: (context, state) {
        final status = authProvider.status;

        // Stay on splash until loadUser() is finished
        if (!authProvider.isInitialized) {
          return state.fullPath == '/splash' ? null : '/splash';
        }

        // After init, route based on status
        if (status == AuthStatus.authenticated) {
          return '/main';
        }
        if (status == AuthStatus.unauthenticated || status == AuthStatus.error) {
          return '/login';
        }

        return null; // no redirect
      },

      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/main',
          builder: (context, state) => const MainScreen(),
        ),
      ],
    );
  }
}
