import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Transaction with ChangeNotifier {
  final String id;
  final String uid;
  final String goalId;
  final double amount;
  final DateTime date;
  final bool isDebit;

  Transaction({
    required this.id,
    required this.uid,
    required this.goalId,
    required this.amount,
    required this.date,
    required this.isDebit,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      uid: json['uid'],
      goalId: json['goalId'],
      amount: json['amount'],
      date: json['date'],
      isDebit: json['isDebit'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'uid': uid,
      'goalId': goalId,
      'amount': amount,
      'date': date,
      'isDebit': isDebit,
    };
  }

  Map<String, dynamic> toPaystackJson(String email){
    return {
      'amount': (amount * 100).toInt(),
      'reference': '${date.microsecondsSinceEpoch}',
      'currency': 'GHS',
      'email': email,
    };
  }
}
