import 'package:flutter/material.dart';

import '../entities/entities.dart';

@immutable
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final List<String> linkedUsers;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  User(
    this.id, 
    this.email,
    this.firstName,
    this.lastName,
    this.linkedUsers,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn);

  User copyWith(
      {String id,
      String email,
      String firstName,
      String lastName,
      List<String> linkedUsers,
      String createdBy,
      DateTime createdOn,
      String modifiedBy,
      DateTime modifiedOn}) {
    return User(
        id ?? this.id,
        email ?? this.email,
        firstName ?? this.firstName,
        lastName ?? this.lastName,
        linkedUsers ?? this.linkedUsers,
        createdBy ?? this.createdBy,
        createdOn ?? this.createdOn,
        modifiedBy ?? this.modifiedBy,
        modifiedOn ?? this.modifiedOn);
  }

  @override
  int get hashCode =>
    id.hashCode ^ email.hashCode ^ firstName.hashCode ^ lastName.hashCode ^ linkedUsers.hashCode ^
      createdBy.hashCode ^ createdOn.hashCode ^ modifiedBy.hashCode ^ modifiedOn.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          linkedUsers == other.linkedUsers &&
          createdBy == other.createdBy &&
          createdOn == other.createdOn &&
          modifiedBy == other.modifiedBy &&
          modifiedOn == other.modifiedOn;

  @override
  String toString() {
    return '''User { id: $id, 
    email: $email,
    firstName: $firstName,
    lastName: $lastName,
    linkedUsers: $linkedUsers,
    createdBy: $createdBy,
    createdOn: $createdOn,
    modifiedBy: $modifiedBy, 
    modifiedOn: $modifiedOn }''';
  }

  UserEntity toEntity() {
    return UserEntity(
        id,
        email,
        firstName,
        lastName,
        linkedUsers,
        createdBy,
        createdOn,
        modifiedBy,
        modifiedOn);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      entity.id,
      entity.email,
      entity.firstName,
      entity.lastName,
      entity.linkedUsers,
      entity.createdBy,
      entity.createdOn,
      entity.modifiedBy,
      entity.modifiedOn
    );
  }
}
