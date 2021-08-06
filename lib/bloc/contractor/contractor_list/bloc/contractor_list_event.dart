part of 'contractor_list_bloc.dart';

@immutable
abstract class ContractorListEvent {}

class ContractorListRequestDataEvent extends ContractorListEvent {
  // final ContractorTypeIndex contractorType;
  final int contractorTypeID;
  final int factoryID;

  ContractorListRequestDataEvent(this.contractorTypeID, this.factoryID);
}
