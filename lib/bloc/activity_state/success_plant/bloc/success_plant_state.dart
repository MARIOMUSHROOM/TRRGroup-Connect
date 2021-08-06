part of 'success_plant_bloc.dart';

@immutable
abstract class SuccessPlantState {}

class SuccessPlantInitial extends SuccessPlantState {}

class SuccessPlantLoading extends SuccessPlantState {}

class SuccessPlantLoaded extends SuccessPlantState {
  @override
  String toString() => "SuccessPlantLoaded{}";
}

class SuccessPlantNoData extends SuccessPlantState {}

class SuccessPlantError extends SuccessPlantState {
  SuccessPlantError(this.message);
  String message;
  @override
  String toString() => "SuccessPlantError{message: $message}";
}
