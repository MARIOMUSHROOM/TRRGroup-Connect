part of 'contractor_list_bloc.dart';

@immutable
abstract class ContractorListState {}

class ContractorListInitial extends ContractorListState {}

class ContractorListLoading extends ContractorListState {}

class ContractorListLoadFinished extends ContractorListState {}

class ContractorListEmpty extends ContractorListState {}

class ContractorListError extends ContractorListState {
  final String errorMessage;

  ContractorListError(this.errorMessage);

  @override
  String toString() => 'Contractor List Loading Error : error message $errorMessage';
}
