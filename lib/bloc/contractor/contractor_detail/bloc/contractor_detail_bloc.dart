import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import '../../../../home/contractor/models/contractor_model.dart';
import '../../../../provider/contractor_api.dart' as contractorAPI;

part 'contractor_detail_event.dart';
part 'contractor_detail_state.dart';

class ContractorDetailBloc extends Bloc<ContractorDetailEvent, ContractorDetailState> {
  ContractorDetailBloc() : super(ContractorDetailInitial());

  final ContractorDetailItem contractorDetailObj = ContractorDetailItem.instance;

  @override
  Stream<ContractorDetailState> mapEventToState(
    ContractorDetailEvent event,
  ) async* {
    if (event is ContractorDetailRequestDataEvent) {
      yield* _requestContractorData(event.findContractorID);
    }
  }

  Stream<ContractorDetailState> _requestContractorData(int aContractorID) async* {
    yield ContractorDetailLoading();
    try {
      // load data from API
      http.Response response = await contractorAPI.ContractorDetailAPI(aContractorID).getContractorDetail();
      // object load from response
      contractorDetailObj.loadFromHttpData(response);

      if (!contractorDetailObj.isEmpty)
        yield ContractorDetailLoadFinished();
      else
        yield ContractorDetailEmpty();
    } catch (error) {
      yield ContractorDetailError(error.toString());
    }
  }
}
