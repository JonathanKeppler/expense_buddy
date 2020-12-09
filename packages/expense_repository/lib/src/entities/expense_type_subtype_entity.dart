import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ExpenseTypeSubTypeEntity extends Equatable {
  final String id;
  final bool isScoped;
  final List<String> scopedUsers;
  final String subType;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  const ExpenseTypeSubTypeEntity(
    this.id,
    this.isScoped,
    this.scopedUsers,
    this.subType,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn
  );

  @override
  List<Object> get props => [
    id,
    isScoped,
    scopedUsers,
    subType,
    createdBy,
    createdOn,
    modifiedBy,
    modifiedOn
  ];

  @override
  String toString() {
    return '''ExpenseTypeSubTypeEntity { id: $id, 
    isScoped: $isScoped,
    scopedUsers: $scopedUsers,
    subType: $subType, 
    createdBy: $createdBy,
    createdOn: $createdOn, 
    modifiedBy: $modifiedBy,  
    modifiedOn: $modifiedOn }''';
  }

    Map<String, Object> toJson() {
    return {
      "id": id,
      "isScoped": isScoped,
      "scopedUsers": scopedUsers,
      "subType": subType,
      "createdBy": createdBy,
      "createdOn": createdOn,
      "modifiedBy": modifiedBy,
      "modifiedOn": modifiedOn,
    };
  }

  static ExpenseTypeSubTypeEntity fromJson(Map<String, Object> json) {
    return ExpenseTypeSubTypeEntity(
      json["id"] as String,
      json["isScoped"] as bool,
      json["scopedUsers"] as List<String>,
      json["subType"] as String,
      json["createdBy"] as String,
      json["createdOn"] as DateTime,
      json["modifiedBy"] as String,
      json["modifiedOn"] as DateTime,
    );
  }

  static ExpenseTypeSubTypeEntity fromSnapshot(DocumentSnapshot snap) {
    return ExpenseTypeSubTypeEntity(
      snap.id,
      snap['isScoped'],
      snap['scopedUsers'],
      snap['subType'],
      snap['createdBy'],
      snap['createdOn'],
      snap['modifiedBy'],
      snap['modifiedOn'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "isScoped": isScoped,
      "scopedUsers": scopedUsers,
      "subType": subType,
      "createdBy": createdBy,
      "createdOn": createdOn,
      "modifiedBy": modifiedBy,
      "modifiedOn": modifiedOn
    };
  }
}