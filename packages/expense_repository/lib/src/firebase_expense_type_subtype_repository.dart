import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'entities/entities.dart';

class FirebaseExpenseTypeSubTypeRepository implements ExpenseTypeSubTypeRepository {
  CollectionReference _expenseTypeSubTypeCollection;

  @override
  Future<void> addExpenseTypeSubType(ExpenseTypeSubType expenseTypeSubType, String parentDoc) {
    _expenseTypeSubTypeCollection = FirebaseFirestore.instance.collection('expenseTypes').doc(parentDoc).collection('ExpenseTypesSubTypes');
    return _expenseTypeSubTypeCollection.add(expenseTypeSubType.toEntity().toDocument());
  }

  @override
  Future<void> removeExpenseTypeSubType(ExpenseTypeSubType expenseTypeSubType, String parentDoc) {
    _expenseTypeSubTypeCollection = FirebaseFirestore.instance.collection('expenseTypes').doc(parentDoc).collection('ExpenseTypesSubTypes');
    return _expenseTypeSubTypeCollection.doc(expenseTypeSubType.id).delete();
  }

  @override
  Future<void> updateExpenseTypeSubType(ExpenseTypeSubType expenseTypeSubType, String parentDoc) {
    _expenseTypeSubTypeCollection = FirebaseFirestore.instance.collection('expenseTypes').doc(parentDoc).collection('ExpenseTypesSubTypes');
    return _expenseTypeSubTypeCollection.doc(expenseTypeSubType.id).update(expenseTypeSubType.toEntity().toDocument());
  }
  
  @override
  Stream<List<ExpenseTypeSubType>> expenseTypeSubTypes(String parentDoc) {
    _expenseTypeSubTypeCollection = FirebaseFirestore.instance.collection('expenseTypes').doc(parentDoc).collection('ExpenseTypesSubTypes');
    return _expenseTypeSubTypeCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ExpenseTypeSubType.fromEntity(ExpenseTypeSubTypeEntity.fromSnapshot(doc))).toList();
    });
  }
}