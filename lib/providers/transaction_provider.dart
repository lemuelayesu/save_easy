import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:save_easy/models/transaction.dart' as t;
import 'package:cloud_firestore/cloud_firestore.dart' as f;

import '../models/user.dart';

class TransactionProvider with ChangeNotifier{
  Future<List<t.Transaction>> fetchTransactions(User user) async{
    try{
      final transactionSnap = await f.FirebaseFirestore.instance
          .collection('transactions')
          .where('uid', isEqualTo: user.uid)
          .get();

      List<t.Transaction> transactions = [];

      for(final doc in transactionSnap.docs){
        t.Transaction transaction = t.Transaction(
          id: doc['id'] as String,
          uid: doc['uid'] as String,
          goalId: doc['goalId'] as String,
          amount: doc['id'] as double,
          date: (doc['id'] as f.Timestamp).toDate(),
          isDebit: doc['isDebit'] as bool,
        );

        transactions.add(transaction);
        notifyListeners();
      }

      return transactions;
    } catch(error){
      log('Error: $error');
      rethrow;
    }
  }

  Future<void> saveTransaction(t.Transaction newTransaction)async{
    try{
      await f.FirebaseFirestore.instance.collection('transactions').doc(newTransaction.id).set({
        'id': newTransaction.id,
        'uid': newTransaction.uid,
        'goalId': newTransaction.goalId,
        'amount': newTransaction.amount,
        'date': newTransaction.date,
        'isDebit': newTransaction.isDebit,
      });
      notifyListeners();
    }
    catch(error){
      log('Error: $error');
      rethrow;
    }
  }
}