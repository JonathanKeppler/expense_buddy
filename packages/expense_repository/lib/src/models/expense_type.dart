import 'package:flutter/material.dart';

import '../entities/entities.dart';

@immutable
class ExpenseType {
  final String id;
  final String type;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  ExpenseType(
    this.id,
    this.type,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn);

  ExpenseType copyWith(
      {String id,
      String type,
      String createdBy,
      DateTime createdOn,
      String modifiedBy,
      DateTime modifiedOn}) {
    return ExpenseType(
        id ?? this.id,
        type ?? this.type,
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
      other is ExpenseType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          createdBy == other.createdBy &&
          createdOn == other.createdOn &&
          modifiedBy == other.modifiedBy &&
          modifiedOn == other.modifiedOn;

  @override
  String toString() {
    return '''ExpenseType { id: $id, 
      type: $type 
      createdBy: $createdBy 
      createdOn: $createdOn 
      modifiedBy: $modifiedBy 
      modifiedOn: $modifiedOn }''';
  }

  ExpenseTypeEntity toEntity() {
    return ExpenseTypeEntity(
        id,
        type,
        createdBy,
        createdOn,
        modifiedBy,
        modifiedOn
        );
  }

  static ExpenseType fromEntity(ExpenseTypeEntity entity) {
    return ExpenseType(
      entity.id,
      entity.type,
      entity.createdBy,
      entity.createdOn,
      entity.modifiedBy,
      entity.modifiedOn
    );
  }
}
