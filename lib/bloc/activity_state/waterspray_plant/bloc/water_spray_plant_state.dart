part of 'water_spray_plant_bloc.dart';

@immutable
abstract class WaterSprayPlantState {}

class WaterSprayPlantInitial extends WaterSprayPlantState {}

class WaterSprayPlantLoading extends WaterSprayPlantState {}

class WaterSprayPlantLoaded extends WaterSprayPlantState {
  @override
  String toString() => "WaterSprayPlantLoaded{}";
}

class WaterSprayPlantNoData extends WaterSprayPlantState {}

class WaterSprayPlantError extends WaterSprayPlantState {
  WaterSprayPlantError(this.message);
  String message;
  @override
  String toString() => "WaterSprayPlantError{message: $message}";
}
