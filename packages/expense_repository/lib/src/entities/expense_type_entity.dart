import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ExpenseTypeEntity extends Equatable {
  final String id;
  final bool isScoped;
  final String type;
  final List<String> scopedUsers;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  const ExpenseTypeEntity(
    this.id,
    this.isScoped,
    this.type,
    this.scopedUsers,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn
  );

  @override
  List<Object> get props => [
    id,
    isScoped,
    type,
    scopedUsers,
    createdBy,
    createdOn,
    modifiedBy,
    modifiedOn
  ];

  @override
  String toString() {
    return '''ExpenseTypeEntity { id: $id, 
    type: $type,
    isScoped: $isScoped,
    scopedUsers: $scopedUsers,
    createdBy: $createdBy,
    createdOn: $createdOn, 
    modifiedBy: $modifiedBy,  
    modifiedOn: $modifiedOn }''';
  }

    Map<String, Object> toJson() {
    return {
      "id": id,
      "isScoped": isScoped,
      "type": type,
      "scopedUsers": scopedUsers,
      "createdBy": createdBy,
      "createdOn": createdOn,
      "modifiedBy": modifiedBy,
      "modifiedOn": modifiedOn,
    };
  }

  static ExpenseTypeEntity fromJson(Map<String, Object> json) {
    return ExpenseTypeEntity(
      json["id"] as String,
      json["isScoped"] as bool,
      json["type"] as String,
      json["scopedUsers"] as List<String>,
      json["createdBy"] as String,
      json["createdOn"] as DateTime,
      json["modifiedBy"] as String,
      json["modifiedOn"] as DateTime,
    );
  }

  static ExpenseTypeEntity fromSnapshot(DocumentSnapshot snap) {
    return ExpenseTypeEntity(
      snap.id,
      snap['isScoped'],
      snap['type'],
      snap['scopedUsers'],
      snap['createdBy'],
      snap['createdOn'],
      snap['modifiedBy'],
      snap['modifiedOn'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "isScoped": isScoped,
      "type": type,
      "scopedUsers": scopedUsers,
      "createdBy": createdBy,
      "createdOn": createdOn,
      "modifiedBy": modifiedBy,
      "modifiedOn": modifiedOn
    };
  }
}