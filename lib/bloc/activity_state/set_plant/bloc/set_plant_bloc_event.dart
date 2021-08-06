part of 'set_plant_bloc_bloc.dart';

@immutable
abstract class SetPlantBlocEvent {}

class LoadSetPlantInitial extends SetPlantBlocEvent {
  @override
  String toString() => "LoadInitial{}";
}

class LoadSetPlantData extends SetPlantBlocEvent {
  LoadSetPlantData(
    this.inputActivityForm,
  );
  InputActivityForm inputActivityForm;
  @override
  String toString() => "LoadSetPlantData{${this.inputActivityForm}}";
}

class UpdateSetPlantStation extends SetPlantBlocEvent {
  UpdateSetPlantStation(
    this.stationSelected,
  );
  PlotDetail stationSelected;
  @override
  String toString() => "UpdateSetPlantData{}";
}

class UpdateSetPlantStartDate extends SetPlantBlocEvent {
  UpdateSetPlantStartDate(
    this.startDate,
  );
  DateTime startDate;
  @override
  String toString() => "UpdateStartDate{${this.startDate}}";
}

class UpdateSetPlantEndDate extends SetPlantBlocEvent {
  UpdateSetPlantEndDate(
    this.endDate,
  );
  DateTime endDate;
  @override
  String toString() => "UpdateEndDate{${this.endDate}}";
}

class DeleteSetPlant extends SetPlantBlocEvent {
  DeleteSetPlant(
    this.idActivity,
  );
  var idActivity;
  @override
  String toString() => "DeleteSetPlant{${this.idActivity}}";
}
