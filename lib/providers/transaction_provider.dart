import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_easy/models/transaction.dart' as t;
import 'package:cloud_firestore/cloud_firestore.dart' as f;

import '../models/user.dart';

class TransactionProvider with ChangeNotifier {
  Future<List<t.Transaction>> fetchTransactions(User user) async {
    try {
      final transactionSnap = await f.FirebaseFirestore.instance
          .collection('transactions')
          .where('uid', isEqualTo: user.uid)
          .get();

      List<t.Transaction> transactions = [];

      for (final doc in transactionSnap.docs) {
        t.Transaction transaction = t.Transaction(
          id: doc['id'] as String,
          uid: doc['uid'] as String,
          goalId: doc['goalId'] as String,
          amount: doc['amount'] as double,
          date: (doc['date'] as f.Timestamp).toDate(),
          isDebit: doc['isDebit'] as bool,
        );

        transactions.add(transaction);
        notifyListeners();
      }
      return transactions;
    } catch (error) {
      log('Error: $error');
      rethrow;
    }
  }

  Future<void> saveTransaction(t.Transaction newTransaction) async {
    try {
      await f.FirebaseFirestore.instance
          .collection('transactions')
          .doc(newTransaction.id)
          .set({
        'id': newTransaction.id,
        'uid': newTransaction.uid,
        'goalId': newTransaction.goalId,
        'amount': newTransaction.amount,
        'date': newTransaction.date,
        'isDebit': newTransaction.isDebit,
      });
      notifyListeners();
    } catch (error) {
      log('Error: $error');
      rethrow;
    }
  }

  Future<void> updateCustomAmount(
      String id, double currentAmount, double newAmount) async {
    try {
      await FirebaseFirestore.instance
          .collection('customGoals')
          .doc(id)
          .update({
        'current': newAmount + currentAmount,
      });
      notifyListeners();
    } catch (error) {
      log('Error: $error');
      rethrow;
    }
  }

  Future<void> updateTimedAmount(
      String id, double currentAmount, double newAmount) async {
    try {
      await FirebaseFirestore.instance.collection('timedGoals').doc(id).update({
        'current': newAmount + currentAmount,
      });
      notifyListeners();
    } catch (error) {
      log('Error: $error');
      rethrow;
    }
  }

  Future<double> getTotalTransactionAmount(User user) async {
    try {
      List<t.Transaction> transactions = await fetchTransactions(user);

      double totalAmount = transactions.fold(
          0.0, (sum, transaction) => sum + transaction.amount);

      return totalAmount;
    } catch (error) {
      log('Error calculating total transaction amount: $error');
      rethrow;
    }
  }
}
