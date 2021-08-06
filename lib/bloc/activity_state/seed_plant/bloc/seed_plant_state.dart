part of 'seed_plant_bloc.dart';

@immutable
abstract class SeedPlantState {}

class SeedPlantInitial extends SeedPlantState {}

class SeedPlantLoading extends SeedPlantState {}

class SeedPlantLoaded extends SeedPlantState {}

class SeedPlantNoData extends SeedPlantState {}

class SeedPlantError extends SeedPlantState {
  SeedPlantError(this.message);
  String message;
  @override
  String toString() => "SeedPlantError{message: $message}";
}
