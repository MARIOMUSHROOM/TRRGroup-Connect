import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../../home/contractor/models/contractor_type_model.dart';
import '../../../../provider/contractor_api.dart';

part 'contractor_type_event.dart';
part 'contractor_type_state.dart';

class ContractorTypeBloc extends Bloc<ContractorTypeEvent, ContractorTypeState> {
  ContractorTypeBloc() : super(ContractorTypeInitial());

  ContractorTypeGridList contractorTypeList = ContractorTypeGridList.instance;

  @override
  Stream<ContractorTypeState> mapEventToState(
    ContractorTypeEvent event,
  ) async* {
    // if event object is request contractor type list
    if (event is ContractorTypeRequestListEvent) yield* _getContractorTypeFromAPI();
  }

  Stream<ContractorTypeState> _getContractorTypeFromAPI() async* {
    yield ContractorTypeLoading(); // change status of state

    var apiObj = ContractorTypeAPI();
    try {
      Response response = await apiObj.getContractorType();
      // get contractor type list from API
      if (response != null && response.body.isNotEmpty) {
        contractorTypeList.loadFromHttpData(response);
        yield ContractorTypeLoaded(); // change status to loaded
      } else
        yield ContractorTypeNoData(); // there is no data for contractor type
    } catch (e) {
      yield ContractorTypeError(e.toString()); // error
    }
  }
}
