import 'package:flutter/material.dart';

import '../entities/entities.dart';

@immutable
class Expense {
  final String id;
  final double cost;
  final String expenseType;
  final String expenseTypeSubType;
  final DateTime incurredOn;
  final String location;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  Expense(
    this.id, 
    this.cost, 
    this.expenseType, 
    this.expenseTypeSubType,
    this.incurredOn,
    this.location,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn);

  Expense copyWith(
      {String id,
      double cost,
      String expenseType,
      String expenseTypeSubType,
      DateTime incurredOn,
      String location,
      String createdBy,
      DateTime createdOn,
      String modifiedBy,
      DateTime modifiedOn}) {
    return Expense(
        id ?? this.id,
        cost ?? this.cost,
        expenseType ?? this.expenseType,
        expenseTypeSubType ?? this.expenseTypeSubType,
        incurredOn ?? this.incurredOn,
        location ?? this.location,
        createdBy ?? this.createdBy,
        createdOn ?? this.createdOn,
        modifiedBy ?? this.modifiedBy,
        modifiedOn ?? this.modifiedOn);
  }

//TODO: Hashcode?

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Expense &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cost == other.cost &&
          expenseType == other.expenseType &&
          expenseTypeSubType == other.expenseTypeSubType &&
          incurredOn == other.incurredOn &&
          location == other.location &&
          createdBy == other.createdBy &&
          createdOn == other.createdOn &&
          modifiedBy == other.modifiedBy &&
          modifiedOn == other.modifiedOn;

  @override
  String toString() {
    return '''Expense { id: $id, 
    cost: $cost, 
    expenseType: $expenseType, 
    expenseTypeSubType: $expenseTypeSubType, 
    incurredOn: $incurredOn, 
    location: $location,
    createdBy: $createdBy,
    createdOn: $createdOn,
    modifiedBy: $modifiedBy, 
    modifiedOn: $modifiedOn }''';
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
        id,
        cost,
        expenseType,
        expenseTypeSubType,
        incurredOn,
        location,
        createdBy,
        createdOn,
        modifiedBy,
        modifiedOn);
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      entity.id,
      entity.cost,
      entity.expenseType,
      entity.expenseTypeSubType,
      entity.incurredOn,
      entity.location,
      entity.createdBy,
      entity.createdOn,
      entity.modifiedBy,
      entity.modifiedOn
    );
  }
}
