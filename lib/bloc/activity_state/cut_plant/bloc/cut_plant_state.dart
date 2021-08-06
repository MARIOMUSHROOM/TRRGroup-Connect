part of 'cut_plant_bloc.dart';

@immutable
abstract class CutPlantState {}

class CutPlantInitial extends CutPlantState {}

class CutPlantLoading extends CutPlantState {}

class CutPlantLoaded extends CutPlantState {
  @override
  String toString() => "CutPlantLoaded{}";
}

class CutPlantNoData extends CutPlantState {}

class CutPlantError extends CutPlantState {
  CutPlantError(this.message);
  String message;
  @override
  String toString() => "CutPlantError{message: $message}";
}
