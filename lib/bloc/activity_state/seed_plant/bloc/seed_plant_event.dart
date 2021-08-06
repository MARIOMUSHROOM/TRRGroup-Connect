part of 'seed_plant_bloc.dart';

@immutable
abstract class SeedPlantEvent {}

class LoadSeedPlantInitial extends SeedPlantEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadSeedPlantData extends SeedPlantEvent {
  LoadSeedPlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadSeedPlantData{${this.inputActivityForm}}";
}

class UpdateSeedPlantStation extends SeedPlantEvent {
  UpdateSeedPlantStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateSeedPlantData{}";
}

class UpdateSeedPlantStartDate extends SeedPlantEvent {
  UpdateSeedPlantStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateSeedPlantEndDate extends SeedPlantEvent {
  UpdateSeedPlantEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}

class DeleteSeedPlant extends SeedPlantEvent {
  DeleteSeedPlant(
    this.idActivity,
  );
  var idActivity;
  @override
  String toString() => "DeleteSeedPlant{${this.idActivity}}";
}
