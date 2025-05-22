import 'package:flutter/material.dart';
import 'package:plantshop_app/providers/cart_provider_state.dart';
import 'package:plantshop_app/screens/landing_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProviderState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plants Shop',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 130, 170, 87),
            primary: const Color.fromARGB(255, 129, 163, 71),
            secondary: const Color.fromARGB(255, 87, 111, 68),
          ),
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[300],
          ),
          textTheme: const TextTheme(
            displaySmall: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            titleLarge: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w200,
            ),
            titleMedium: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            bodyMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            bodySmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              backgroundColor: WidgetStatePropertyAll(
                Color.fromARGB(250, 143, 189, 63),
              ),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 30,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(
              0xff161D0D,
            ),
          )),
      home: const LandingScreen(),
    );
  }
}
