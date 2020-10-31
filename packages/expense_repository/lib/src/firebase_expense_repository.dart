import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'entities/entities.dart';
import 'models/expense.dart';

class FirebaseExpenseRepository implements ExpenseRepository {
  final expenseCollection = FirebaseFirestore.instance.collection('Expenses');

  @override
  Future<void> addExpense(Expense expense) {
    return expenseCollection.add(expense.toEntity().toDocument());
  }

  @override
  Future<void> removeExpense(Expense expense) {
    return expenseCollection.doc(expense.id).delete();
  }

  @override
  Future<void> updateExpense(Expense expense) {
    return expenseCollection.doc(expense.id).update(expense.toEntity().toDocument());
  }
  
  @override
  Stream<List<Expense>> expenses() {
    return expenseCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Expense.fromEntity(ExpenseEntity.fromSnapshot(doc))).toList();
    });
  }
}