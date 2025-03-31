import 'package:flutter/material.dart';
import 'package:nebulaboard/splash.dart';
import 'package:nebulaboard/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nebula Board',
      theme: NebulaBoardTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
