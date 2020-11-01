import 'package:flutter/material.dart';

import '../entities/entities.dart';

@immutable
class ExpenseTypeSubType {
  final String id;
  final String subType;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  ExpenseTypeSubType(
    this.id,
    this.subType,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn);

  ExpenseTypeSubType copyWith(
      {String id,
      String subType,
      String createdBy,
      DateTime createdOn,
      String modifiedBy,
      DateTime modifiedOn}) {
    return ExpenseTypeSubType(
        id ?? this.id,
        subType ?? this.subType,
        createdBy ?? this.createdBy,
        createdOn ?? this.createdOn,
        modifiedBy ?? this.modifiedBy,
        modifiedOn ?? this.modifiedOn,
    );
  }

//TODO: Hashcode?

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTypeSubType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          subType == other.subType &&
          createdBy == other.createdBy &&
          createdOn == other.createdOn &&
          modifiedBy == other.modifiedBy &&
          modifiedOn == other.modifiedOn;

  @override
  String toString() {
    return '''ExpenseTypeSubType { id: $id, 
      subType: $subType 
      createdBy: $createdBy 
      createdOn: $createdOn 
      modifiedBy: $modifiedBy 
      modifiedOn: $modifiedOn }''';
  }

  ExpenseTypeSubTypeEntity toEntity() {
    return ExpenseTypeSubTypeEntity(
        id,
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
      entity.subType,
      entity.createdBy,
      entity.createdOn,
      entity.modifiedBy,
      entity.modifiedOn
    );
  }
}
