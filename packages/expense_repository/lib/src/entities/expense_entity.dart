import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final String id;
  final double cost;
  final String expenseType;
  final String expenseTypeSubType;
  final DateTime incurredOn;
  final String location;
  final List<String> scopedUsers;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  const ExpenseEntity(
    this.id,
    this.cost,
    this.expenseType,
    this.expenseTypeSubType,
    this.incurredOn,
    this.location,
    this.scopedUsers,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn
  );

  @override
  List<Object> get props => [
    id,
    cost,
    expenseType,
    expenseTypeSubType,
    incurredOn,
    location,
    scopedUsers,
    createdBy,
    createdOn,
    modifiedBy,
    modifiedOn
  ];

  @override
  String toString() {
    return '''ExpenseEntity { id: $id, 
    cost: $cost, 
    expenseType: $expenseType, 
    expenseTypeSubType: $expenseTypeSubType, 
    incurredOn: $incurredOn, 
    location: $location,
    scopedUsers: $scopedUsers,
    createdBy: $createdBy,
    createdOn: $createdOn, 
    modifiedBy: $modifiedBy,  
    modifiedOn: $modifiedOn }''';
  }

    Map<String, Object> toJson() {
    return {
      "id": id,
      "cost": cost,
      "expenseType": expenseType,
      "expenseTypeSubType": expenseTypeSubType,
      "incurredOn": incurredOn,
      "location": location,
      "scopedUsers": scopedUsers,
      "createdBy": createdBy,
      "createdOn": createdOn,
      "modifiedBy": modifiedBy,
      "modifiedOn": modifiedOn,
    };
  }

  static ExpenseEntity fromJson(Map<String, Object> json) {
    return ExpenseEntity(
      json["id"] as String,
      json["cost"] as double,
      json["expenseType"] as String,
      json["expenseTypeSubType"] as String,
      json["incurredOn"] as DateTime,
      json["location"] as String,
      json["scopedUsers"] as List<String>,
      json["createdBy"] as String,
      json["createdOn"] as DateTime,
      json["modifiedBy"] as String,
      json["modifiedOn"] as DateTime,
    );
  }

  static ExpenseEntity fromSnapshot(DocumentSnapshot snap) {
    return ExpenseEntity(
      snap.id,
      snap['cost'],
      snap['expenseType'],
      snap['expenseTypeSubType'],
      snap['incurredOn'],
      snap['location'],
      snap['scopedUsers'],
      snap['createdBy'],
      snap['createdOn'],
      snap['modifiedBy'],
      snap['modifiedOn'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "cost": cost,
      "expenseType": expenseType,
      "expenseTypeSubType": expenseTypeSubType,
      "incurredOn": incurredOn,
      "location": location,
      "scopedUsers": scopedUsers,
      "createdBy": createdBy,
      "createdOn": createdOn,
      "modifiedBy": modifiedBy,
      "modifiedOn": modifiedOn
    };
  }
}