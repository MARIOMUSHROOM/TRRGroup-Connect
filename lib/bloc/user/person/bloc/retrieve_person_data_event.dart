part of 'retrieve_person_data_bloc.dart';

@immutable
abstract class RetrievePersonDataEvent {}

class RetrieveNormalPersonDataEvent extends RetrievePersonDataEvent {
  final int userID;
  final int factoryID;
  RetrieveNormalPersonDataEvent(this.userID, this.factoryID);
}

class RetrieveSpecialPersonDataEvent extends RetrievePersonDataEvent {
  final int userSpecialID;
  RetrieveSpecialPersonDataEvent(this.userSpecialID);
}

// class RetrieveGuestPersonDataEvent extends RetrievePersonDataEvent {
//   final int userGuestID;
//   RetrieveGuestPersonDataEvent(this.userGuestID);
// }
