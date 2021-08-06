part of 'set_plant_bloc_bloc.dart';

@immutable
abstract class SetPlantBlocState {}

class SetPlantInitial extends SetPlantBlocState {}

class SetPlantLoading extends SetPlantBlocState {}

class SetPlantLoaded extends SetPlantBlocState {}

class SetPlantNoData extends SetPlantBlocState {}

class SetPlantError extends SetPlantBlocState {
  SetPlantError(this.message);
  String message;
  @override
  String toString() => "SetPlantBlocError{message: $message}";
}
