part of 'contractor_type_bloc.dart';

@immutable
abstract class ContractorTypeState {}

class ContractorTypeInitial extends ContractorTypeState {}

class ContractorTypeLoading extends ContractorTypeState {}

class ContractorTypeLoaded extends ContractorTypeState {}

class ContractorTypeNoData extends ContractorTypeState {}

// ignore: must_be_immutable
class ContractorTypeError extends ContractorTypeState {
  String errorMessage;
  ContractorTypeError(this.errorMessage);

  @override
  String toString() {
    return 'ContractorTypeError : error message $errorMessage';
  }
}
