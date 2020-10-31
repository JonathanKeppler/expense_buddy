import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final String id;
  final double cost;
  final String expenseType;
  final String expenseTypeSubType;
  final String location;
  final DateTime incurredOn;

  const ExpenseEntity(
    this.id,
    this.cost,
    this.expenseType,
    this.expenseTypeSubType,
    this.location,
    this.incurredOn,
  );

  @override
  List<Object> get props => [
    id,
    cost,
    expenseType,
    expenseTypeSubType,
    location,
    incurredOn
  ];

  @override
  String toString() {
    return 'ExpenseEntity { id: $id, cost: $cost, expenseType: $expenseType, expenseTypeSubType: $expenseTypeSubType, incurredOn: $incurredOn }';
  }

    Map<String, Object> toJson() {
    return {
      "id": id,
      "cost": cost,
      "expenseType": expenseType,
      "expenseTypeSubType": expenseTypeSubType,
      "location": location,
      "incurredOn": incurredOn,
    };
  }

  static ExpenseEntity fromJson(Map<String, Object> json) {
    return ExpenseEntity(
      json["id"] as String,
      json["cost"] as double,
      json["expenseType"] as String,
      json["expenseTypeSubType"] as String,
      json["location"] as String,
      json["incurredOn"] as DateTime,
    );
  }

  static ExpenseEntity fromSnapshot(DocumentSnapshot snap) {
    return ExpenseEntity(
      snap.id,
      snap['cost'],
      snap['expenseType'],
      snap['expenseTypeSubType'],
      snap['location'],
      snap['incurredOn'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "cost": cost,
      "expenseType": expenseType,
      "expenseTypeSubType": expenseTypeSubType,
      "location": location,
      "incurredOn": incurredOn
    };
  }



}