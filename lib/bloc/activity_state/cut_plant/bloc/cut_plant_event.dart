part of 'cut_plant_bloc.dart';

@immutable
abstract class CutPlantEvent {}

class LoadCutPlantInitial extends CutPlantEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadCutPlantData extends CutPlantEvent {
  LoadCutPlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadCutPlantData{${this.inputActivityForm}}";
}

class UpdateCutPlantStation extends CutPlantEvent {
  UpdateCutPlantStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateCutPlantData{}";
}

class UpdateCutPlantStartDate extends CutPlantEvent {
  UpdateCutPlantStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateCutPlantEndDate extends CutPlantEvent {
  UpdateCutPlantEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}

class DeleteCutPlant extends CutPlantEvent {
  DeleteCutPlant(
    this.idActivity,
  );
  var idActivity;
  @override
  String toString() => "DeleteCutPlant{${this.idActivity}}";
}
