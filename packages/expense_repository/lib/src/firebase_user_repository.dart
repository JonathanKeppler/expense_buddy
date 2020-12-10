import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'entities/entities.dart';

class FirebaseUserRepository implements UserRepository {
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUser(User user) {
    return userCollection.add(user.toEntity().toDocument());
  }

  @override
  Future<void> removeUser(User user) {
    return userCollection.doc(user.id).delete();
  }

  @override
  Future<void> updateUser(User user) {
    return userCollection.doc(user.id).update(user.toEntity().toDocument());
  }
  
  @override
  Stream<List<User>> users() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc))).toList();
    });
  }
}