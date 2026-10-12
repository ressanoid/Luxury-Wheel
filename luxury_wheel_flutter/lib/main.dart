import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'client.dart';
import 'screens/luxury_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const LuxuryWheelApp());
}

class LuxuryWheelApp extends StatelessWidget {
  const LuxuryWheelApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF181916);
    const paper = Color(0xFFF7F6F1);
    const brass = Color(0xFFB79A62);

    return MaterialApp(
      title: 'Luxury Wheel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brass,
          brightness: Brightness.light,
          surface: paper,
          primary: ink,
          secondary: brass,
        ),
        textTheme: GoogleFonts.manropeTextTheme().apply(
          bodyColor: ink,
          displayColor: ink,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: paper,
          foregroundColor: ink,
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: paper,
          indicatorColor: brass.withValues(alpha: 0.16),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: ink,
          contentTextStyle: GoogleFonts.manrope(color: Colors.white),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const LuxuryHomeScreen(),
    );
  }
}
