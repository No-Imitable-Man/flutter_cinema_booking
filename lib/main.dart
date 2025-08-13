import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking/cinema_app_ui/pages/cinema_main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CinemaMainScreen(),
    );
  }
}
