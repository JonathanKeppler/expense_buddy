import 'package:flutter/material.dart';

import '../entities/entities.dart';

@immutable
class ExpenseTypeSubType {
  final String id;
  final bool isScoped;
  final List<String> scopedUsers;
  final String subType;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  ExpenseTypeSubType(
    this.id,
    this.isScoped,
    this.scopedUsers,
    this.subType,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn);

  ExpenseTypeSubType copyWith(
      {String id,
      bool isScoped,
      List<String> scopedUsers,
      String subType,
      String createdBy,
      DateTime createdOn,
      String modifiedBy,
      DateTime modifiedOn}) {
    return ExpenseTypeSubType(
        id ?? this.id,
        isScoped ?? this.isScoped,
        scopedUsers ?? this.scopedUsers,
        subType ?? this.subType,
        createdBy ?? this.createdBy,
        createdOn ?? this.createdOn,
        modifiedBy ?? this.modifiedBy,
        modifiedOn ?? this.modifiedOn,
    );
  }

  @override
  int get hashCode =>
    id.hashCode ^ isScoped.hashCode ^ scopedUsers.hashCode ^ subType.hashCode ^ createdBy.hashCode ^
      createdOn.hashCode ^ modifiedBy.hashCode ^ modifiedOn.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTypeSubType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          isScoped == other.isScoped &&
          scopedUsers == other.scopedUsers &&
          subType == other.subType &&
          createdBy == other.createdBy &&
          createdOn == other.createdOn &&
          modifiedBy == other.modifiedBy &&
          modifiedOn == other.modifiedOn;

  @override
  String toString() {
    return '''ExpenseTypeSubType { id: $id, 
      isScoped: $isScoped,
      scopedUsers: $scopedUsers,
      subType: $subType 
      createdBy: $createdBy 
      createdOn: $createdOn 
      modifiedBy: $modifiedBy 
      modifiedOn: $modifiedOn }''';
  }

  ExpenseTypeSubTypeEntity toEntity() {
    return ExpenseTypeSubTypeEntity(
        id,
        isScoped,
        scopedUsers,
        subType,
        createdBy,
        createdOn,
        modifiedBy,
        modifiedOn
        );
  }

  static ExpenseTypeSubType fromEntity(ExpenseTypeSubTypeEntity entity) {
    return ExpenseTypeSubType(
      entity.id,
      entity.isScoped,
      entity.scopedUsers,
      entity.subType,
      entity.createdBy,
      entity.createdOn,
      entity.modifiedBy,
      entity.modifiedOn
    );
  }
}
