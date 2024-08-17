import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_easy/models/user.dart' as u;
import 'package:save_easy/providers/user_provider.dart';

class AuthService {
  static Future<void> signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> signUp(
    u.User user,
    String password,
    BuildContext context,
  ) async {
    try {
      final UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      await userProvider.saveUserDetails(user);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> signOut(BuildContext context) async{
    try{
      await FirebaseAuth.instance.signOut();
    }
    catch(error){
      rethrow;
    }
  }
}
