import 'dart:async';

import 'models/models.dart';

abstract class UserRepository {
  Future<void> addUser(User user);

  Future<void> removeUser(User user);

  Future<void> updateUser(User user);

  Stream<List<User>> users();
}