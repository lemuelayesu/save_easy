import 'package:flutter/material.dart';

class CustomGoal with ChangeNotifier {
  final String uid;
  final String id;
  final String name;
  final double amount;
  final double current;

  CustomGoal({
    required this.uid,
    required this.id,
    required this.name,
    required this.amount,
    required this.current,
  });
}

class TimedGoal with ChangeNotifier {
  final String uid;
  final String id;
  final int months;
  final DateTime startDate;
  final double current;

  TimedGoal({
    required this.uid,
    required this.id,
    required this.months,
    required this.startDate,
    required this.current,
  });
}
