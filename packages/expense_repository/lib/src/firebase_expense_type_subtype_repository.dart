import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'entities/entities.dart';

class FirebaseExpenseTypeSubTypeRepository implements ExpenseTypeSubTypeRepository {
  CollectionReference _expenseTypeSubTypeCollection;

  @override
  Future<void> addExpenseTypeSubType(
    AuthUser authUser,
    ExpenseType expenseType,
    ExpenseTypeSubType expenseTypeSubType) {
    _expenseTypeSubTypeCollection = FirebaseFirestore.instance.collection('expenseTypes')
      .doc(expenseType.id).collection('ExpenseTypesSubTypes');
    return _expenseTypeSubTypeCollection.add(expenseTypeSubType.toEntity().toDocument());
  }

  @override
  Future<void> removeExpenseTypeSubType(
    AuthUser authUser,
    ExpenseType expenseType,
    ExpenseTypeSubType expenseTypeSubType) {
    _expenseTypeSubTypeCollection = FirebaseFirestore.instance.collection('expenseTypes')
      .doc(expenseType.id).collection('ExpenseTypesSubTypes');
    return _expenseTypeSubTypeCollection.doc(expenseTypeSubType.id).delete();
  }

  @override
  Future<void> updateExpenseTypeSubType(
    AuthUser authUser,
    ExpenseType expenseType,
    ExpenseTypeSubType expenseTypeSubType) {
    _expenseTypeSubTypeCollection = FirebaseFirestore.instance.collection('expenseTypes')
      .doc(expenseType.id).collection('ExpenseTypesSubTypes');
    return _expenseTypeSubTypeCollection.doc(expenseTypeSubType.id).update(expenseTypeSubType.toEntity().toDocument());
  }
  
  @override
  Stream<List<ExpenseTypeSubType>> expenseTypeSubTypes(
    AuthUser authUser,
    ExpenseType expenseType
  ) {
    _expenseTypeSubTypeCollection = FirebaseFirestore.instance.collection('expenseTypes')
      .doc(expenseType.id).collection('ExpenseTypesSubTypes');

    // const query = _expenseTypeSubTypeCollection.where("isScoped", isEqualTo: true);

    return _expenseTypeSubTypeCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ExpenseTypeSubType.fromEntity(ExpenseTypeSubTypeEntity.fromSnapshot(doc))).toList();
    });
  }
}