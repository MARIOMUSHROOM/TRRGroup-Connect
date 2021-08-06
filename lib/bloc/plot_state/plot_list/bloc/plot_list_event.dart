part of 'plot_list_bloc.dart';

@immutable
abstract class PlotListEvent {}

class LoadPlotListInitial extends PlotListEvent {
  @override
  String toString() => "LoadPlotListInitial{}";
}

class UpdatePlotListYear extends PlotListEvent {
  UpdatePlotListYear(this.selectedYear);
  LastCurrentYear selectedYear;
  @override
  String toString() => "UpdatePlotListYear{}";
}

class SortPlotList extends PlotListEvent {
  SortPlotList(this.sortData);
  StationDetail sortData;
  @override
  String toString() => "SortPlotList{}";
}

class ClearSortPlotList extends PlotListEvent {
  ClearSortPlotList();
  @override
  String toString() => "ClearSortPlotList{}";
}
