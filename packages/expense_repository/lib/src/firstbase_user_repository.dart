import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'entities/entities.dart';

class FirebaseUserRepository implements UserRepository {
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUser(User user) {
    return expenseCollection.add(expense.toEntity().toDocument());
  }

  @override
  Future<void> removeUser(User user) {
    return expenseCollection.doc(expense.id).delete();
  }

  @override
  Future<void> updateUser(User user) {
    return expenseCollection.doc(expense.id).update(expense.toEntity().toDocument());
  }
  
  @override
  Stream<List<User>> users() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc))).toList();
    });
  }
}