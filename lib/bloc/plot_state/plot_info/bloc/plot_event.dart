part of 'plot_bloc.dart';

@immutable
abstract class PlotEvent {}

class LoadPlotInitial extends PlotEvent {
  @override
  String toString() => "LoadPlotInitial{}";
}

class SelectIndexTab extends PlotEvent {
  SelectIndexTab(this.indexTab);
  int indexTab;
  @override
  String toString() => "SelectIndexTab{}";
}
