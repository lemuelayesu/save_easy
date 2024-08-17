import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_easy/models/user.dart' as u;

class UserProvider with ChangeNotifier {
  u.User _user = u.User(
    fullName: 'Full Name',
    email: 'Email',
    phoneNumber: 'Phone Number',
    uid: '0',
  );

  u.User get user => _user;

  Future<u.User> fetchUserDetails(String email) async {
    try{
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email'.toLowerCase(), isEqualTo: email)
          .get();

      final userDoc = userSnapshot.docs.first;

      u.User user = u.User(
        fullName: userDoc['fullName'] as String,
        email: userDoc['email'] as String,
        uid: userDoc['uid'] as String,
        phoneNumber: userDoc['phoneNumber'] as String,
      );

      _user = user;
      notifyListeners();
      return _user;
    }
    catch(error){
      rethrow;
    }
  }

  Future<void> saveUserDetails(u.User user) async{
    try{
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'uid': user.uid,
        'phoneNumber': user.phoneNumber,
      });
      notifyListeners();
    }
    catch(error){
      rethrow;
    }
  }
}
