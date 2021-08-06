part of 'manure_plant_bloc.dart';

@immutable
abstract class ManurePlantState {}

class ManurePlantInitial extends ManurePlantState {}

class ManurePlantLoading extends ManurePlantState {}

class ManurePlantLoaded extends ManurePlantState {
  @override
  String toString() => "ManurePlantLoaded{}";
}

class ManurePlantNoData extends ManurePlantState {}

class ManurePlantError extends ManurePlantState {
  ManurePlantError(this.message);
  String message;
  @override
  String toString() => "ManurePlantError{message: $message}";
}
