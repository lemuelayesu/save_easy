import 'package:flutter/material.dart';

class CustomGoal with ChangeNotifier {
  final String uid;
  final String id;
  final String name;
  final double amount;

  CustomGoal({
    required this.uid,
    required this.id,
    required this.name,
    required this.amount,
  });
}

class TimedGoal with ChangeNotifier {
  final String uid;
  final String id;
  final int months;

  TimedGoal({
    required this.uid,
    required this.id,
    required this.months,
  });
}
