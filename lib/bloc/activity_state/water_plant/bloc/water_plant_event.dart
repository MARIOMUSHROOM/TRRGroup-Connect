part of 'water_plant_bloc.dart';

@immutable
abstract class WaterPlantEvent {}

class LoadWaterPlantInitial extends WaterPlantEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadWaterPlantData extends WaterPlantEvent {
  LoadWaterPlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadWaterPlantData{${this.inputActivityForm}}";
}

class UpdateStation extends WaterPlantEvent {
  UpdateStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateWaterPlantData{}";
}

class UpdateStartDate extends WaterPlantEvent {
  UpdateStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateEndDate extends WaterPlantEvent {
  UpdateEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}

class DeleteWaterPlant extends WaterPlantEvent {
  DeleteWaterPlant(
    this.idActivity,
  );
  var idActivity;
  @override
  String toString() => "DeleteWaterPlant{${this.idActivity}}";
}
