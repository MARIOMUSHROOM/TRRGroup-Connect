import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../user/models/person_data_model.dart';
import '../../../../provider/user_api.dart';
import '../../../../profile/models/profile_json_model.dart';

part 'retrieve_person_data_event.dart';
part 'retrieve_person_data_state.dart';

class RetrievePersonDataBloc extends Bloc<RetrievePersonDataEvent, RetrievePersonDataState> {
  RetrievePersonDataBloc() : super(RetrievePersonDataInitial());

  BasicPersonDataModel currentPersonObjPointer; // Store result each return state object
  final PreparePersonDataAPI _personAPI = PreparePersonDataAPI.instance;

  @override
  Stream<RetrievePersonDataState> mapEventToState(
    RetrievePersonDataEvent event,
  ) async* {
    currentPersonObjPointer = null;
    if (event is RetrieveNormalPersonDataEvent)
      // besically get profile object
      yield* _getNormalPersonObj(event.userID, event.factoryID);
    else if (event is RetrieveSpecialPersonDataEvent)
      // get profile and special user object
      yield* _getSpecialPersonObj(event.userSpecialID);
    // get guest user
    // else if (event is RetrieveGuestPersonDataEvent) yield* _getGuestPersonObj(event.userGuestID);
  }

  Stream<RetrievePersonDataState> _getNormalPersonObj(int aUserID, int aFactoryID) async* {
    yield RetrievingPersonDataState();
    try {
      // Production code
      // get Normal user data from TRR API
      http.Response response = await _personAPI.getNormalPerson(aUserID, aFactoryID);
      if (response != null && response.body.isNotEmpty) {
        ProfileJsonModel _tempProfile = ProfileJsonModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
        NormalPersonDataModel normalPerson = NormalPersonDataModel()..profileJsonObj.copyFrom(_tempProfile);
        currentPersonObjPointer = normalPerson;
        // print('${this.runtimeType} : profile name : ${(currentPersonObjPointer as NormalPersonDataModel).profileJsonObj.firstName}');
        yield RetrievePersonDataCompleteState();
      } else
        RetrievePersonDataFailState();

      // Testing code
      // ProfileJsonModel testProfile = ProfileJsonModel(firstName: 'Profile', lastName: 'Json');
      // if (testProfile.firstName != '') {
      //   NormalPersonDataModel testNormalPerson = NormalPersonDataModel()..profileJsonObj.copyFrom(testProfile);
      //   currentPersonObjPointer = testNormalPerson;
      //   yield RetrievePersonDataCompleteState();
      // } else
      //   yield RetrievePersonDataFailState();
    } catch (error) {
      yield RetrievePersonDataErrorState(error.toString());
    }
  }

  Stream<RetrievePersonDataState> _getSpecialPersonObj(int aUserSpecialID) async* {
    yield RetrievingPersonDataState();
    try {
      SpecialPersonfDataModel resultSpecialPersonObj = SpecialPersonfDataModel();
      if (await _personAPI.getSpecialPersonByID(aUserSpecialID, resultSpecialPersonObj)) {
        currentPersonObjPointer = resultSpecialPersonObj;
        yield RetrievePersonDataCompleteState();
      } else
        yield RetrievePersonDataFailState();
    } catch (error) {
      yield RetrievePersonDataErrorState(error.toString());
    }
  }

  // Stream<RetrievePersonDataState> _getGuestPersonObj(int aUserGuestID) async* {
  //   yield RetrievingPersonDataState();
  //   try {} catch (error) {
  //     yield RetrievePersonDataErrorState(error.toString());
  //   }
  // }
}
