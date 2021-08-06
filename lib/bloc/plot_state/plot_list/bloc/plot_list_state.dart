part of 'plot_list_bloc.dart';

@immutable
abstract class PlotListState {}

class PlotListInitial extends PlotListState {}

class PlotListLoading extends PlotListState {}

class PlotListLoaded extends PlotListState {
  PlotListLoaded();
  @override
  String toString() => "PlotListLoaded{}";
}

class PlotListNoData extends PlotListState {}

class PlotListError extends PlotListState {
  PlotListError(this.message);
  String message;
  @override
  String toString() => "PlotListError{message: $message}";
}

class PlotYearListLoaded extends PlotListState {
  PlotYearListLoaded();
  @override
  String toString() => "PlotYearListLoaded{}";
}
