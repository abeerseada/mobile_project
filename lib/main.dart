import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/home_screen.dart';
import 'pages/details_screen.dart';
import 'pages/favorites_screen.dart';
import 'pages/settings_screen.dart';
import 'pages/login_screen.dart';
import 'models/place.dart';

void main() {
  print('App starting...');
  runApp(const TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  const TravelGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // البداية من Splash
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        FavoritesScreen.routeName: (_) => const FavoritesScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == DetailsScreen.routeName &&
            settings.arguments is Place) {
          final place = settings.arguments as Place;
          return MaterialPageRoute(builder: (_) => DetailsScreen(place: place));
        }
        return null;
      },
    );
  }
}
