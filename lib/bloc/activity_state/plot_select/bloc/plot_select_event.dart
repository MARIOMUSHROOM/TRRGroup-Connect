part of 'plot_select_bloc.dart';

@immutable
abstract class PlotSelectEvent {}

class LoadPlotData extends PlotSelectEvent {
  LoadPlotData(
    this.selectedYear,
  );
  String selectedYear;
  @override
  String toString() => "LoadSeedPlantData{${this.selectedYear}}";
}
