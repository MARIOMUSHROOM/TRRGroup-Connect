import 'dart:async';
// import 'package:ai_flutter/bloc/contractor/contractor_type/bloc/contractor_type_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../provider/contractor_api.dart';

import '../../../../home/contractor/models/contractor_type_model.dart';
import '../../../../home/contractor/models/contractor_model.dart';

part 'contractor_list_event.dart';
part 'contractor_list_state.dart';

class ContractorListBloc extends Bloc<ContractorListEvent, ContractorListState> {
  ContractorListBloc() : super(ContractorListInitial());

  final ContractorList contractorList = ContractorList.instance;

  @override
  Stream<ContractorListState> mapEventToState(
    ContractorListEvent event,
  ) async* {
    // if event is request contractor list
    if (event is ContractorListRequestDataEvent) {
      // send contractorTypeID and factoryID to API
      yield* _loadContractorList(event.contractorTypeID, event.factoryID);
    }
  }

  Stream<ContractorListState> _loadContractorList(int aContractorTypeID, int aFactoryID) async* {
    yield ContractorListLoading();
    try {
      // get contractor list from API
      http.Response responseList = await ContractorListAPI(aContractorTypeID, aFactoryID).getContractorList();
      // load contractor list from response
      contractorList.loadFromHttpData(responseList);
      if (contractorList.isNotEmpty)
        yield ContractorListLoadFinished();
      else
        yield ContractorListEmpty();
    } catch (e) {
      ContractorListError(e.toString());
    }
  }
}
