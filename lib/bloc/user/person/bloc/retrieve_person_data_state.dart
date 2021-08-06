part of 'retrieve_person_data_bloc.dart';

@immutable
abstract class RetrievePersonDataState {}

class RetrievePersonDataInitial extends RetrievePersonDataState {}

class RetrievingPersonDataState extends RetrievePersonDataState {}

class RetrievePersonDataCompleteState extends RetrievePersonDataState {}

class RetrievePersonDataFailState extends RetrievePersonDataState {}
// datt not found or incorrect

class RetrievePersonDataErrorState extends RetrievePersonDataState {
  final String errorMessage;
  RetrievePersonDataErrorState(this.errorMessage);

  @override
  String toString() {
    return 'Retrieve Personal data error with message : $errorMessage';
  }
}
