import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'expense_type_subtype_event.dart';
part 'expense_type_subtype_state.dart';

class ExpenseTypeSubTypeBloc extends Bloc<ExpenseTypeSubTypeEvent, ExpenseTypeSubTypeState> {
  final ExpenseTypeSubTypeRepository _expenseTypeSubTypeRepository;
  StreamSubscription _expenseTypeSubTypeSubscription;

  ExpenseTypeSubTypeBloc({@required ExpenseTypeSubTypeRepository expenseTypeSubTypeRepository})
   : assert(expenseTypeSubTypeRepository != null),
   _expenseTypeSubTypeRepository = expenseTypeSubTypeRepository,
   super(ExpenseTypeSubTypesLoadingState());

  @override
  Stream<ExpenseTypeSubTypeState> mapEventToState(ExpenseTypeSubTypeEvent event) async* {
    if (event is LoadExpenseTypeSubTypesEvent) {
      yield* _mapLoadExpenseTypeSubTypesToState();
    } else if (event is AddExpenseTypeSubTypeEvent) {
      yield* _mapAddExpenseTypeSubTypeEventToState(event);
    } else if (event is UpdateExpenseTypeSubTypeEvent) {
      yield* _mapUpdateExpenseTypeSubTypeEventToState(event);
    } else if (event is RemoveExpenseTypeSubTypeEvent) {
      yield* _mapRemoveExpenseTypeSubTypeEventToState(event);
    } else if (event is ExpenseTypeSubTypesUpdatedEvent) {
      yield* _mapExpenseTypeSubTypesUpdatedEventToState(event);
    }
  }

  Stream<ExpenseTypeSubTypeState> _mapLoadExpenseTypeSubTypesToState() async* {
    _expenseTypeSubTypeSubscription?.cancel();
    _expenseTypeSubTypeSubscription = _expenseTypeSubTypeRepository.expenseTypeSubTypes().listen(
      (expenseTypeSubTypes) => add(ExpenseTypeSubTypesUpdatedEvent(expenseTypeSubTypes))
    );
  }

  Stream<ExpenseTypeSubTypeState> _mapAddExpenseTypeSubTypeEventToState(AddExpenseTypeSubTypeEvent event) async* {
    _expenseTypeSubTypeRepository.addExpenseTypeSubType(event.authUser, event.expenseType, event.expenseTypeSubType);
  }

  Stream<ExpenseTypeSubTypeState> _mapUpdateExpenseTypeSubTypeEventToState(UpdateExpenseTypeSubTypeEvent event) async* {
    _expenseTypeSubTypeRepository.updateExpenseTypeSubType(event.authUser, event.expenseType, event.expenseTypeSubType);
  }

  Stream<ExpenseTypeSubTypeState> _mapRemoveExpenseTypeSubTypeEventToState(RemoveExpenseTypeSubTypeEvent event) async* {
    _expenseTypeSubTypeRepository.removeExpenseTypeSubType(event.authUser, event.expenseType, event.expenseTypeSubType);
  }

  Stream<ExpenseTypeSubTypeState> _mapExpenseTypeSubTypesUpdatedEventToState(ExpenseTypeSubTypesUpdatedEvent event) async* {
    yield ExpenseTypeSubTypesLoadedState(event.expenseTypeSubTypes);
  }

  @override
  Future<void> close() {
    _expenseTypeSubTypeSubscription?.cancel();
    return super.close();
  }
}
