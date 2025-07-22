import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../typography/app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    colorSchemeSeed: AppColors.lightTeal.color,
    brightness: Brightness.light,
    textTheme: _textTheme,
    useMaterial3: true,
    appBarTheme: _appBarTheme,
  );

  static ThemeData get darkTheme => ThemeData(
    colorSchemeSeed: AppColors.lightTeal.color,
    brightness: Brightness.dark,
    textTheme: _textTheme,
    useMaterial3: true,
    appBarTheme: _appBarTheme,
  );

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLargeBold,
      bodyMedium: AppTextStyles.bodyLargeMedium,
      bodySmall: AppTextStyles.bodyLargeRegular,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
    );
  }

  static ColorScheme get appDarkColorScheme => ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF00AA13),
    onPrimary: Color(0xFF000000),
    secondary: Color(0xFFE0E0E0),
    onSecondary: Color(0xFF000000),
    background: Color(0xFF121212),
    onBackground: Color(0xFFFFFFFF),
    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFE0E0E0),
    error: Color(0xFFFF4C4C),
    onError: Color(0xFF000000),
  );

  static ColorScheme get applightColorScheme => ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF00AA13),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF161616),
    onSecondary: Color(0xFFFFFFFF),
    background: Color(0xFFF6F6F6),
    onBackground: Color(0xFF000000),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF161616),
    error: Color(0xFFFF4C4C),
    onError: Color(0xFFFFFFFF),
  );

}
