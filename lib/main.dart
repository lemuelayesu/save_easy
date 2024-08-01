import 'package:flutter/material.dart';
import 'package:save_easy/consts/theme.dart';
//import 'package:save_easy/screens/onboarding.dart';
import 'package:save_easy/screens/savings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: const Savings(),
    );
  }
}
