part of 'ship_plant_bloc.dart';

@immutable
abstract class ShipPlantState {}

class ShipPlantInitial extends ShipPlantState {}

class ShipPlantLoading extends ShipPlantState {}

class ShipPlantLoaded extends ShipPlantState {
  @override
  String toString() => "ShipPlantLoaded{}";
}

class ShipPlantNoData extends ShipPlantState {}

class ShipPlantError extends ShipPlantState {
  ShipPlantError(this.message);
  String message;
  @override
  String toString() => "ShipPlantError{message: $message}";
}
