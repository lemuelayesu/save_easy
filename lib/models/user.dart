import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String uid;

  User({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.uid,
  });
}
