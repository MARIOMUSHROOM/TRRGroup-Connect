import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'plot_event.dart';
part 'plot_state.dart';

class PlotBloc extends Bloc<PlotEvent, PlotState> {
  PlotBloc() : super(PlotInitial());

  int tabIndex;
  @override
  Stream<PlotState> mapEventToState(
    PlotEvent event,
  ) async* {
    if (event is LoadPlotInitial) {
      tabIndex = 0;
      yield PlotLoaded(tabIndex);
    } else if (event is SelectIndexTab) {
      tabIndex = event.indexTab;
      yield PlotLoaded(tabIndex);
    }
  }
}
