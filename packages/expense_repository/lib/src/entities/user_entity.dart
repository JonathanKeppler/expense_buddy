import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final List<String> linkedUsers;
  final String createdBy;
  final DateTime createdOn;
  final String modifiedBy;
  final DateTime modifiedOn;

  const UserEntity(
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.linkedUsers,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn
  );

  @override
  List<Object> get props => [
    id,
    email,
    firstName,
    lastName,
    linkedUsers,
    createdBy,
    createdOn,
    modifiedBy,
    modifiedOn
  ];

  @override
  String toString() {
    return '''UserEntity { id: $id, 
    email: $email,
    firstName: $firstName,
    lastName: $lastName,
    linkedUsers: $linkedUsers,
    createdBy: $createdBy,
    createdOn: $createdOn, 
    modifiedBy: $modifiedBy,  
    modifiedOn: $modifiedOn }''';
  }

    Map<String, Object> toJson() {
    return {
      "id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "linkedUsers": linkedUsers,
      "createdBy": createdBy,
      "createdOn": createdOn,
      "modifiedBy": modifiedBy,
      "modifiedOn": modifiedOn,
    };
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json["id"] as String,
      json["email"] as String,
      json["firstName"] as String,
      json["lastName"] as String,
      json["linkedUsers"] as List<String>,
      json["createdBy"] as String,
      json["createdOn"] as DateTime,
      json["modifiedBy"] as String,
      json["modifiedOn"] as DateTime,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.id,
      snap['email'],
      snap['firstName'],
      snap['lastName'],
      snap['linkedUsers'],
      snap['createdBy'],
      snap['createdOn'],
      snap['modifiedBy'],
      snap['modifiedOn'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "linkedUsers": linkedUsers,
      "createdBy": createdBy,
      "createdOn": createdOn,
      "modifiedBy": modifiedBy,
      "modifiedOn": modifiedOn
    };
  }
}