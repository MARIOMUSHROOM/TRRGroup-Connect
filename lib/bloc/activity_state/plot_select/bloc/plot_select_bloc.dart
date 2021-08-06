import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'plot_select_event.dart';
part 'plot_select_state.dart';

class PlotSelectBloc extends Bloc<PlotSelectEvent, PlotSelectState> {
  PlotSelectBloc() : super(PlotSelectInitial());

  @override
  Stream<PlotSelectState> mapEventToState(
    PlotSelectEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
