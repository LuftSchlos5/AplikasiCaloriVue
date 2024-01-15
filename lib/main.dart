import 'package:flutter/material.dart';
import 'package:flutter_tubes/home_screen.dart';
import 'package:flutter_tubes/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(), // Ganti '/splash' menjadi '/home'
      },
    );
  }
}
