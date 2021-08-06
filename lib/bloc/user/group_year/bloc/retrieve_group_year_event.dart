part of 'retrieve_group_year_bloc.dart';

@immutable
abstract class RetrieveGroupYearEvent {}

class RetrieveUserGroupYearEvent extends RetrieveGroupYearEvent {
  final int userID;
  final int factoryID;
  RetrieveUserGroupYearEvent(this.userID, this.factoryID);
}
