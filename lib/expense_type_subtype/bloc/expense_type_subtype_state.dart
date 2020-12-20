part of 'expense_type_subtype_bloc.dart';

abstract class ExpenseTypeSubTypeState extends Equatable {
  const ExpenseTypeSubTypeState();
  
  @override
  List<Object> get props => [];
}

class ExpenseTypeSubTypesLoadingState extends ExpenseTypeSubTypeState {}

class ExpenseTypeSubTypesLoadedState extends ExpenseTypeSubTypeState {
  final List<ExpenseTypeSubType> expenseTypeSubTypes;

  const ExpenseTypeSubTypesLoadedState([this.expenseTypeSubTypes = const []]);

  @override
  List<Object> get props => [expenseTypeSubTypes];

  @override
  toString() => 'ExpenseTypeSubTypesLoadedState { expenseTypeSubTypes: $expenseTypeSubTypes }';
}

class ExpenseTypeSubTypesNotLoadedState extends ExpenseTypeSubTypeState {}
