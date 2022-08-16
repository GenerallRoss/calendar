// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Statuses on _Statuses, Store {
  late final _$matrixStatusAtom =
      Atom(name: '_Statuses.matrixStatus', context: context);

  @override
  Map<DateTime, List<List<Status?>>> get matrixStatus {
    _$matrixStatusAtom.reportRead();
    return super.matrixStatus;
  }

  @override
  set matrixStatus(Map<DateTime, List<List<Status?>>> value) {
    _$matrixStatusAtom.reportWrite(value, super.matrixStatus, () {
      super.matrixStatus = value;
    });
  }

  late final _$rangeDatesAtom =
      Atom(name: '_Statuses.rangeDates', context: context);

  @override
  List<DateTime?> get rangeDates {
    _$rangeDatesAtom.reportRead();
    return super.rangeDates;
  }

  @override
  set rangeDates(List<DateTime?> value) {
    _$rangeDatesAtom.reportWrite(value, super.rangeDates, () {
      super.rangeDates = value;
    });
  }

  late final _$_StatusesActionController =
      ActionController(name: '_Statuses', context: context);

  @override
  List<List<Status?>> initMatrixStatus(List<List<DateTime?>> matrixDate) {
    final _$actionInfo = _$_StatusesActionController.startAction(
        name: '_Statuses.initMatrixStatus');
    try {
      return super.initMatrixStatus(matrixDate);
    } finally {
      _$_StatusesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToRange(DateTime? pickedDate, DateTime dateTime, int week, int day) {
    final _$actionInfo =
        _$_StatusesActionController.startAction(name: '_Statuses.addToRange');
    try {
      return super.addToRange(pickedDate, dateTime, week, day);
    } finally {
      _$_StatusesActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<int> getCountWeeks(DateTime date) {
    final _$actionInfo = _$_StatusesActionController.startAction(
        name: '_Statuses.getCountWeeks');
    try {
      return super.getCountWeeks(date);
    } finally {
      _$_StatusesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
matrixStatus: ${matrixStatus},
rangeDates: ${rangeDates}
    ''';
  }
}
