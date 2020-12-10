import 'package:flutter/material.dart';

import '../entities/entities.dart';

@immutable
class ExpenseType {
  final String id;
  final bool isScoped;
  final String type;
  final List<String> scopedUsers;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  ExpenseType(
    this.id,
    this.isScoped,
    this.type,
    this.scopedUsers,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn);

  ExpenseType copyWith(
      {String id,
      bool isScoped,
      String type,
      List<String> scopedUsers,
      String createdBy,
      DateTime createdOn,
      String modifiedBy,
      DateTime modifiedOn}) {
    return ExpenseType(
        id ?? this.id,
        isScoped ?? this.isScoped,
        type ?? this.type,
        scopedUsers ?? this.scopedUsers,
        createdBy ?? this.createdBy,
        createdOn ?? this.createdOn,
        modifiedBy ?? this.modifiedBy,
        modifiedOn ?? this.modifiedOn,
    );
  }

  @override
  int get hashCode =>
    id.hashCode ^ isScoped.hashCode ^ type.hashCode ^ scopedUsers.hashCode ^
      createdBy.hashCode ^ createdOn.hashCode ^ modifiedBy.hashCode ^ modifiedOn.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          isScoped == other.isScoped &&
          type == other.type &&
          scopedUsers == other.scopedUsers &&
          createdBy == other.createdBy &&
          createdOn == other.createdOn &&
          modifiedBy == other.modifiedBy &&
          modifiedOn == other.modifiedOn;

  @override
  String toString() {
    return '''ExpenseType { id: $id,
      isScoped: $isScoped,
      type: $type,
      scopedUsers: $scopedUsers, 
      createdBy: $createdBy, 
      createdOn: $createdOn, 
      modifiedBy: $modifiedBy, 
      modifiedOn: $modifiedOn }''';
  }

  ExpenseTypeEntity toEntity() {
    return ExpenseTypeEntity(
        id,
        isScoped,
        type,
        scopedUsers,
        createdBy,
        createdOn,
        modifiedBy,
        modifiedOn
        );
  }

  static ExpenseType fromEntity(ExpenseTypeEntity entity) {
    return ExpenseType(
      entity.id,
      entity.isScoped,
      entity.type,
      entity.scopedUsers,
      entity.createdBy,
      entity.createdOn,
      entity.modifiedBy,
      entity.modifiedOn
    );
  }
}
