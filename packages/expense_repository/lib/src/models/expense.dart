import 'package:flutter/material.dart';

import '../entities/entities.dart';

@immutable
class Expense {
  final String id;
  final double cost;
  final String expenseType;
  final String expenseTypeSubType;
  final String location;
  final DateTime incurredOn;

  Expense(this.id, this.cost, this.expenseType, this.expenseTypeSubType,
      this.location, this.incurredOn);

  Expense copyWith(
      {String id,
      double cost,
      String expenseType,
      String expenseTypeSubType,
      String location,
      DateTime incurredOn}) {
    return Expense(
        id ?? this.id,
        cost ?? this.cost,
        expenseType ?? this.expenseType,
        expenseTypeSubType ?? this.expenseTypeSubType,
        location ?? this.location,
        incurredOn ?? this.incurredOn);
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
          location == other.location &&
          incurredOn == other.incurredOn;

  @override
  String toString() {
    return 'Expense { id: $id, cost: $cost, expenseType: $expenseType, expenseTypeSubType: $expenseTypeSubType, incurredOn: $incurredOn }';
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
        id, cost, expenseType, expenseTypeSubType, location, incurredOn);
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      entity.id,
      entity.cost,
      entity.expenseType,
      entity.expenseTypeSubType,
      entity.location,
      entity.incurredOn,
    );
  }
}
