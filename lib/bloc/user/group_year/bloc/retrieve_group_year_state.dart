part of 'retrieve_group_year_bloc.dart';

@immutable
abstract class RetrieveGroupYearState {}

class RetrieveGroupYearInitial extends RetrieveGroupYearState {}

class RetrieveGroupYearLoadingState extends RetrieveGroupYearState {}

class RetrieveGroupYearFinishState extends RetrieveGroupYearState {}

class RetrieveGroupYearEmptyState extends RetrieveGroupYearState {}

class RetrieveGroupYearErrorState extends RetrieveGroupYearState {
  final String errorMessage;
  RetrieveGroupYearErrorState(this.errorMessage);

  @override
  String toString() => 'Retrieve Group Year from server error with message $errorMessage';
}
