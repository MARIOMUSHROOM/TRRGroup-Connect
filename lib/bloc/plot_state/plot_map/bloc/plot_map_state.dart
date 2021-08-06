part of 'plot_map_bloc.dart';

@immutable
abstract class PlotMapState {}

class PlotMapInitial extends PlotMapState {}

class PlotMapLoading extends PlotMapState {}

class PlotMapLoaded extends PlotMapState {
  PlotMapLoaded(this.stationList);
  PlotMapModel stationList;
  @override
  String toString() => "SugarcaneLoaded{}";
}

class PlotMapNoData extends PlotMapState {}

class PlotMapError extends PlotMapState {
  PlotMapError(this.message);
  String message;
  @override
  String toString() => "SugarcaneError{message: $message}";
}
