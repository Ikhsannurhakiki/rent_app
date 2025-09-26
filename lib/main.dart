import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/data/usecase/auth/firebase/get_current_user.dart';
import 'package:rent_app/presentation/provider/auth_provider.dart';
import 'package:rent_app/presentation/provider/book_notifier.dart';
import 'package:rent_app/presentation/provider/main_provider.dart';
import 'package:rent_app/presentation/provider/map_provider.dart';
import 'package:rent_app/presentation/provider/unit_notifier.dart';
import 'package:rent_app/presentation/style/theme/app_theme.dart';
import 'package:rent_app/routes/go_router_service.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'data/usecase/auth/firebase/login_user.dart';
import 'data/usecase/auth/firebase/logout_user.dart';
import 'data/usecase/auth/firebase/register_user.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

  final repository = AuthRepositoryImpl();
  final authProvider = AuthProvider(
    registerUser: RegisterUser(repository),
    loginUser: LoginUser(repository),
    logoutUser: LogoutUser(repository),
    getCurrentUser: GetCurrentUser(repository),
  );
  await authProvider.loadUser();

  final goRouterService = GoRouterService(authProvider);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<MainProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<UnitNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<MapProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<BookNotifier>()),
        ChangeNotifierProvider.value(value: authProvider), // already created
      ],
      child: MyApp(routerService: goRouterService),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouterService routerService;
  const MyApp({super.key, required this.routerService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: AppTheme.applightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: AppTheme.appDarkColorScheme,
        useMaterial3: true,
      ),
      routerConfig: routerService.router,
    );
  }
}
