import 'package:firebase_auth/firebase_auth.dart';

String firebaseEmail = FirebaseAuth.instance.currentUser!.email.toString();