part of 'plot_bloc.dart';

@immutable
abstract class PlotState {}

class PlotInitial extends PlotState {}

class PlotLoading extends PlotState {}

class PlotLoaded extends PlotState {
  PlotLoaded(this.tabIndex);
  int tabIndex;
  @override
  String toString() => "PlotLoaded{}";
}

class PlotNoData extends PlotState {}

class PlotError extends PlotState {
  PlotError(this.message);
  String message;
  @override
  String toString() => "PlotError{message: $message}";
}
