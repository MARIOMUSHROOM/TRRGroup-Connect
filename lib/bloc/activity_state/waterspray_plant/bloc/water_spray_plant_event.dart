part of 'water_spray_plant_bloc.dart';

@immutable
abstract class WaterSprayPlantEvent {}

class LoadWaterSprayPlantInitial extends WaterSprayPlantEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadWaterSprayPlantData extends WaterSprayPlantEvent {
  LoadWaterSprayPlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadWaterSprayPlantData{${this.inputActivityForm}}";
}

class UpdateWaterSprayPlantStation extends WaterSprayPlantEvent {
  UpdateWaterSprayPlantStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateWaterSprayPlantData{}";
}

class UpdateWaterSprayPlantStartDate extends WaterSprayPlantEvent {
  UpdateWaterSprayPlantStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateWaterSprayPlantEndDate extends WaterSprayPlantEvent {
  UpdateWaterSprayPlantEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}

class DeleteWaterSprayPlant extends WaterSprayPlantEvent {
  DeleteWaterSprayPlant(
    this.idActivity,
  );
  var idActivity;
  @override
  String toString() => "DeleteWaterSprayPlant{${this.idActivity}}";
}
