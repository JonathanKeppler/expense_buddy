import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'expense_type_event.dart';
part 'expense_type_state.dart';

class ExpenseTypeBloc extends Bloc<ExpenseTypeEvent, ExpenseTypeState> {
  final ExpenseTypeRepository _expenseTypeRepository;
  StreamSubscription _expenseTypeSubscription;

  ExpenseTypeBloc({@required ExpenseTypeRepository expenseTypeRepository})
   : assert(expenseTypeRepository != null),
   _expenseTypeRepository = expenseTypeRepository,
   super(ExpenseTypesLoadingState());

  @override
  Stream<ExpenseTypeState> mapEventToState(ExpenseTypeEvent event) async* {
    if (event is LoadExpenseTypesEvent) {
      yield* _mapLoadExpenseTypesToState();
    } else if (event is AddExpenseTypeEvent) {
      yield* _mapAddExpenseTypeEventToState(event);
    } else if (event is UpdateExpenseTypeEvent) {
      yield* _mapUpdateExpenseTypeEventToState(event);
    } else if (event is RemoveExpenseTypeEvent) {
      yield* _mapRemoveExpenseTypeEventToState(event);
    } else if (event is ExpenseTypesUpdatedEvent) {
      yield* _mapExpenseTypesUpdatedEventToState(event);
    }
  }

  Stream<ExpenseTypeState> _mapLoadExpenseTypesToState() async* {
    _expenseTypeSubscription?.cancel();
    _expenseTypeSubscription = _expenseTypeRepository.expenseTypes().listen(
      (expenseTypes) => add(ExpenseTypesUpdatedEvent(expenseTypes))
    );
  }

  Stream<ExpenseTypeState> _mapAddExpenseTypeEventToState(AddExpenseTypeEvent event) async* {
    _expenseTypeRepository.addExpenseType(event.expense);
  }

  Stream<ExpenseTypeState> _mapUpdateExpenseTypeEventToState(UpdateExpenseTypeEvent event) async* {
    _expenseTypeRepository.updateExpenseType(event.expense);
  }

  Stream<ExpenseTypeState> _mapRemoveExpenseTypeEventToState(RemoveExpenseTypeEvent event) async* {
    _expenseTypeRepository.removeExpenseType(event.expense);
  }

  Stream<ExpenseTypeState> _mapExpenseTypesUpdatedEventToState(ExpenseTypesUpdatedEvent event) async* {
    yield ExpenseTypesLoadedState(event.expenses);
  }

  @override
  Future<void> close() {
    _expenseTypeSubscription?.cancel();
    return super.close();
  }
}
