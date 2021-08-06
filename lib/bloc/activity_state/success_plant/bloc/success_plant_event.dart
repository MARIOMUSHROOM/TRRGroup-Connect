part of 'success_plant_bloc.dart';

@immutable
abstract class SuccessPlantEvent {}

class LoadSuccessPlantInitial extends SuccessPlantEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadSuccessPlantData extends SuccessPlantEvent {
  LoadSuccessPlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadSuccessPlantData{${this.inputActivityForm}}";
}

class UpdateSuccessPlantStation extends SuccessPlantEvent {
  UpdateSuccessPlantStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateSuccessPlantData{}";
}

class UpdateSuccessPlantStartDate extends SuccessPlantEvent {
  UpdateSuccessPlantStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateSuccessPlantEndDate extends SuccessPlantEvent {
  UpdateSuccessPlantEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}
