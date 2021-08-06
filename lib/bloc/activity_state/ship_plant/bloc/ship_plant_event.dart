part of 'ship_plant_bloc.dart';

@immutable
abstract class ShipPlantEvent {}

class LoadShipPlantInitial extends ShipPlantEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadShipPlantData extends ShipPlantEvent {
  LoadShipPlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadShipPlantData{${this.inputActivityForm}}";
}

class UpdateShipPlantStation extends ShipPlantEvent {
  UpdateShipPlantStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateShipPlantData{}";
}

class UpdateShipPlantStartDate extends ShipPlantEvent {
  UpdateShipPlantStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateShipPlantEndDate extends ShipPlantEvent {
  UpdateShipPlantEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}

class DeleteShipPlant extends ShipPlantEvent {
  DeleteShipPlant(
    this.idActivity,
  );
  var idActivity;
  @override
  String toString() => "DeleteShipPlant{${this.idActivity}}";
}
