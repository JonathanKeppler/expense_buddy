part of 'expense_type_subtype_bloc.dart';

abstract class ExpenseTypeSubTypeEvent extends Equatable {
  const ExpenseTypeSubTypeEvent();

  @override
  List<Object> get props => [];
}

class LoadExpenseTypeSubTypesEvent extends ExpenseTypeSubTypeEvent {
  final AuthUser authUser;
  final ExpenseType expenseType;

  const LoadExpenseTypeSubTypesEvent(this.authUser, this.expenseType);

  @override
  List<Object> get props => [authUser, expenseType]

  @override
  toString() => 'LoadExpenseTypeSubTypesEvent { authUser: $authUser, expenseType: $expenseType }';
}

class AddExpenseTypeSubTypeEvent extends ExpenseTypeSubTypeEvent {
  final AuthUser authUser;
  final ExpenseType expenseType;
  final ExpenseTypeSubType expenseTypeSubType;

  const AddExpenseTypeSubTypeEvent(this.authUser, this.expenseType, this.expenseTypeSubType);
  
  @override
  List<Object> get props => [authUser, expenseType, expenseTypeSubType];

  @override toString() => '''AddExpenseTypeSubTypeEvent { authUser: $authUser, 
    expenseType: $expenseType, 
    expense: $expenseTypeSubType }''';
}

class UpdateExpenseTypeSubTypeEvent extends ExpenseTypeSubTypeEvent {
  final AuthUser authUser;
  final ExpenseType expenseType;
  final ExpenseTypeSubType expenseTypeSubType;

  const UpdateExpenseTypeSubTypeEvent(this.authUser, this.expenseType, this.expenseTypeSubType);

  @override
  List<Object> get props => [authUser, expenseType, expenseTypeSubType];

  @override
  toString() => '''UpdateExpenseTypeSubTypeEvent { authUser: $authUser, 
    expenseType: $expenseType, 
    expense: $expenseTypeSubType }''';
}

class RemoveExpenseTypeSubTypeEvent extends ExpenseTypeSubTypeEvent {
  final AuthUser authUser;
  final ExpenseType expenseType;
  final ExpenseTypeSubType expenseTypeSubType;

  const RemoveExpenseTypeSubTypeEvent(this.authUser, this.expenseType, this.expenseTypeSubType);

  @override
  List<Object> get props => [authUser, expenseType, expenseTypeSubType];

  @override
  toString() => '''RemoveExpenseTypeSubTypeEvent { authUser: $authUser, 
    expenseType: $expenseType, 
    expense: $expenseTypeSubType }''';
}

class ExpenseTypeSubTypesUpdatedEvent extends ExpenseTypeSubTypeEvent {
  final List<ExpenseTypeSubType> expenseTypeSubTypes;

  const ExpenseTypeSubTypesUpdatedEvent(this.expenseTypeSubTypes);

  @override
  List<Object> get props => [expenseTypeSubTypes];
}


