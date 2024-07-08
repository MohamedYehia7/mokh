part of 'unit_cubit.dart';

@immutable
sealed class UnitState {}

final class UnitInitial extends UnitState {}

class UnitLoading extends UnitState {}

class UnitLoaded extends UnitState {
  final List<Unit> units;

  UnitLoaded(this.units);
}

class UnitError extends UnitState {
  final String message;

  UnitError(this.message);
}
