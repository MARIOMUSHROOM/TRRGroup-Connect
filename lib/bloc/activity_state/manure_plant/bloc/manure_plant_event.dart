part of 'manure_plant_bloc.dart';

@immutable
abstract class ManurePlantEvent {}

class LoadManurePlantInitial extends ManurePlantEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadManurePlantData extends ManurePlantEvent {
  LoadManurePlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadManurePlantData{${this.inputActivityForm}}";
}

class UpdateManurePlantStation extends ManurePlantEvent {
  UpdateManurePlantStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateManurePlantData{}";
}

class UpdateManurePlantStartDate extends ManurePlantEvent {
  UpdateManurePlantStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateManurePlantEndDate extends ManurePlantEvent {
  UpdateManurePlantEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}

class DeleteManurePlant extends ManurePlantEvent {
  DeleteManurePlant(
    this.idActivity,
  );
  var idActivity;
  @override
  String toString() => "DeleteManurePlant{${this.idActivity}}";
}
