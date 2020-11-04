import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'entities/entities.dart';

class FirebaseExpenseTypeRepository implements ExpenseTypeRepository {
  final expenseTypeCollection = FirebaseFirestore.instance.collection('expenseTypes');

  @override
  Future<void> addExpenseType(ExpenseType expenseType) {
    return expenseTypeCollection.add(expenseType.toEntity().toDocument());
  }

  @override
  Future<void> removeExpenseType(ExpenseType expenseType) {
    return expenseTypeCollection.doc(expenseType.id).delete();
  }

  @override
  Future<void> updateExpenseType(ExpenseType expenseType) {
    return expenseTypeCollection.doc(expenseType.id).update(expenseType.toEntity().toDocument());
  }
  
  @override
  Stream<List<ExpenseType>> expenseTypes() {
    return expenseTypeCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ExpenseType.fromEntity(ExpenseTypeEntity.fromSnapshot(doc))).toList();
    });
  }
}