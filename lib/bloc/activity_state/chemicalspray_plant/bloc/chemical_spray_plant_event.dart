part of 'chemical_spray_plant_bloc.dart';

@immutable
abstract class ChemicalSprayPlantEvent {}

class LoadChemicalSprayPlantInitial extends ChemicalSprayPlantEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadChemicalSprayPlantData extends ChemicalSprayPlantEvent {
  LoadChemicalSprayPlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadChemicalSprayPlantData{${this.inputActivityForm}}";
}

class UpdateChemicalSprayPlantStation extends ChemicalSprayPlantEvent {
  UpdateChemicalSprayPlantStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateChemicalSprayPlantData{}";
}

class UpdateChemicalSprayPlantStartDate extends ChemicalSprayPlantEvent {
  UpdateChemicalSprayPlantStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateChemicalSprayPlantEndDate extends ChemicalSprayPlantEvent {
  UpdateChemicalSprayPlantEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}

class DeleteChemicalSprayPlant extends ChemicalSprayPlantEvent {
  DeleteChemicalSprayPlant(
    this.idActivity,
  );
  var idActivity;
  @override
  String toString() => "DeleteChemicalSprayPlant{${this.idActivity}}";
}
