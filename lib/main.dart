import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/login_screen.dart';
import 'views/signup_screen.dart';
import 'views/main_screen.dart';
import 'views/onboarding_screen.dart'; // Asegúrate de crear este archivo y su contenido
import 'services/auth_service.dart';
import 'services/binance_service.dart';

void main() {
  runApp(MyApp());
}

const Color binanceYellow = Color(0xFFFCD535);
const Color binanceGrey = Color(0xFF212529);
const Color binanceBlue = Color(0xFF007bff);

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<BinanceService>(
          create: (_) => BinanceService(),
        ),
      ],
      child: MaterialApp(
        title: 'Crypto App',
        theme: ThemeData(
          // Aplicación del tema de Binance a la aplicación
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: binanceBlue,
            secondary: binanceYellow,
          ),
          useMaterial3: true,
        ),
        // Cambio de la ruta inicial a la pantalla de onboarding
        initialRoute: '/onboarding',
        routes: {
          '/onboarding': (context) => OnboardingScreen(), // Pantalla de onboarding
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/mainScreen': (context) => MainScreen(),
        },
      ),
    );
  }
}
