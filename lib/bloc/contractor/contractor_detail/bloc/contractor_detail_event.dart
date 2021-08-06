part of 'contractor_detail_bloc.dart';

@immutable
abstract class ContractorDetailEvent {}

class ContractorDetailRequestDataEvent extends ContractorDetailEvent {
  final int findContractorID;

  ContractorDetailRequestDataEvent(this.findContractorID);
}
