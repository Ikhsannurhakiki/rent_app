import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/presentation/provider/book_notifier.dart';
import 'package:rent_app/presentation/provider/main_provider.dart';
import 'package:rent_app/presentation/provider/map_provider.dart';
import 'package:rent_app/presentation/provider/unit_notifier.dart';
import 'package:rent_app/presentation/screens/main_screen.dart';
import 'package:rent_app/presentation/style/theme/app_theme.dart';

import 'injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider.value(value: di.locator<UnitNotifier>()),
        ChangeNotifierProvider.value(value: di.locator<MapProvider>()),
        ChangeNotifierProvider.value(value: di.locator<BookNotifier>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: AppTheme.applightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: AppTheme.appDarkColorScheme,
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
