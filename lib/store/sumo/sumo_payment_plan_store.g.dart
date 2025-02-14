// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sumo_payment_plan_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SumoPaymentPlanStore on _SumoPaymentPlanStore, Store {
  late final _$plansAtom =
      Atom(name: '_SumoPaymentPlanStore.plans', context: context);

  @override
  ObservableList<Map<String, dynamic>> get plans {
    _$plansAtom.reportRead();
    return super.plans;
  }

  @override
  set plans(ObservableList<Map<String, dynamic>> value) {
    _$plansAtom.reportWrite(value, super.plans, () {
      super.plans = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SumoPaymentPlanStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_SumoPaymentPlanStore.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchPaymentPlansAsyncAction =
      AsyncAction('_SumoPaymentPlanStore.fetchPaymentPlans', context: context);

  @override
  Future<void> fetchPaymentPlans() {
    return _$fetchPaymentPlansAsyncAction.run(() => super.fetchPaymentPlans());
  }

  @override
  String toString() {
    return '''
plans: ${plans},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
