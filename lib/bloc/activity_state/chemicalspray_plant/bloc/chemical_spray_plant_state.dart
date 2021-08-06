part of 'chemical_spray_plant_bloc.dart';

@immutable
abstract class ChemicalSprayPlantState {}

class ChemicalSprayPlantInitial extends ChemicalSprayPlantState {}

class ChemicalSprayPlantLoading extends ChemicalSprayPlantState {}

class ChemicalSprayPlantLoaded extends ChemicalSprayPlantState {
  @override
  String toString() => "ChemicalSprayPlantLoaded{}";
}

class ChemicalSprayPlantNoData extends ChemicalSprayPlantState {}

class ChemicalSprayPlantError extends ChemicalSprayPlantState {
  ChemicalSprayPlantError(this.message);
  String message;
  @override
  String toString() => "ChemicalSprayPlantError{message: $message}";
}
