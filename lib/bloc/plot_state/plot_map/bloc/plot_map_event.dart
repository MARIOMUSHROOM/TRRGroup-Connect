part of 'plot_map_bloc.dart';

@immutable
abstract class PlotMapEvent {}

class LoadPlotMapInitial extends PlotMapEvent {
  LoadPlotMapInitial(this.yearSelected);
  int yearSelected;
  @override
  String toString() => "LoadPlotMapInitial{}";
}
