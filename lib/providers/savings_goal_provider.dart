import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_easy/models/savings_goal.dart';

class SavingsGoalProvider with ChangeNotifier {
  Future<void> saveCustomGoal(CustomGoal customGoal) async {
    try {
      await FirebaseFirestore.instance
          .collection('customGoals')
          .doc(customGoal.id)
          .set({
        'id': customGoal.id,
        'uid': customGoal.uid,
        'name': customGoal.name,
        'amount': customGoal.amount,
      });
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<CustomGoal>> fetchCustomGoals(String uid) async {
    try {
      final goalSnapshot = await FirebaseFirestore.instance
          .collection('customGoals')
          .where('uid', isEqualTo: uid)
          .get();

      final goalDoc = goalSnapshot.docs;

      List<CustomGoal> customGoals = [];

      for (final doc in goalDoc) {
        CustomGoal goal = CustomGoal(
          uid: doc['uid'] as String,
          id: doc['id'] as String,
          name: doc['name'] as String,
          amount: doc['amount'] as double,
        );
        customGoals.add(goal);
        notifyListeners();
      }
      return customGoals;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> saveTimedGoal(TimedGoal timedGoal) async {
    try {
      await FirebaseFirestore.instance
          .collection('timedGoals')
          .doc(timedGoal.id)
          .set({
        'uid': timedGoal.uid,
        'id': timedGoal.id,
        'months': timedGoal.months,
      });
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TimedGoal>> fetchTimedGoals(String uid) async {
    try {
      final goalSnapshot = await FirebaseFirestore.instance
          .collection('timedGoals')
          .where('uid', isEqualTo: uid)
          .get();

      final goalDoc = goalSnapshot.docs;

      List<TimedGoal> timedGoals = [];

      for (final doc in goalDoc) {
        TimedGoal goal = TimedGoal(
          uid: doc['uid'] as String,
          id: doc['id'] as String,
          months: doc['months'] as int,
        );
        timedGoals.add(goal);
        notifyListeners();
      }
      return timedGoals;
    } catch (error) {
      rethrow;
    }
  }
}
