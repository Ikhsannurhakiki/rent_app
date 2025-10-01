import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/provider/auth_provider.dart';
import 'package:rent_app/presentation/provider/book_notifier.dart';
import 'package:rent_app/presentation/provider/main_provider.dart';
import 'package:rent_app/presentation/provider/map_provider.dart';
import 'package:rent_app/presentation/provider/owner_notifier.dart';
import 'package:rent_app/presentation/provider/unit_notifier.dart';
import 'package:rent_app/routes/go_router_service.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<MainProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<UnitNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<MapProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<BookNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<OwnerNotifier>())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final goRouter = AppRouter.router(context);

    return MaterialApp.router(
      title: 'Rent App',
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
    );
  }
}
