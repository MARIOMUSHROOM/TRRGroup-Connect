part of 'water_plant_bloc.dart';

@immutable
abstract class WaterPlantState {}

class WaterPlantInitial extends WaterPlantState {}

class WaterPlantLoading extends WaterPlantState {}

class WaterPlantLoaded extends WaterPlantState {
  @override
  String toString() => "WaterPlantLoaded{}";
}

class WaterPlantNoData extends WaterPlantState {}

class WaterPlantError extends WaterPlantState {
  WaterPlantError(this.message);
  String message;
  @override
  String toString() => "WaterPlantError{message: $message}";
}
