import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

String firebaseEmail = FirebaseAuth.instance.currentUser!.email.toString();

String formatAmount(double amount) {
  final formatter = NumberFormat("#,##0.00", "en_UK");
  return formatter.format(amount);
}
