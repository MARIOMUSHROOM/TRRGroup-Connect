part of 'contractor_detail_bloc.dart';

@immutable
abstract class ContractorDetailState {}

class ContractorDetailInitial extends ContractorDetailState {}

class ContractorDetailLoading extends ContractorDetailState {}

class ContractorDetailLoadFinished extends ContractorDetailState {}

class ContractorDetailEmpty extends ContractorDetailState {}

class ContractorDetailError extends ContractorDetailState {
  final String errorMessage;

  ContractorDetailError(this.errorMessage);

  @override
  String toString() => 'Contractor List Loading Error : error message $errorMessage';
}
