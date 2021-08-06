import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../provider/user_api.dart';
import '../../../../user/models/guest_user_json_model.dart';
import '../../../../user/models/person_data_model.dart';

part 'validate_guest_user_event.dart';
part 'validate_guest_user_state.dart';

class ValidateGuestUserBloc extends Bloc<ValidateGuestUserEvent, ValidateGuestUserState> {
  ValidateGuestUserBloc() : super(ValidateGuestUserInitial());

  GuestUserAPI _guestAPI = GuestUserAPI.instance;
  GuestUserJsonModel guestUserObj = GuestUserJsonModel.instance;

  GuestPersonDataModel currentGuestPerson;

  @override
  Stream<ValidateGuestUserState> mapEventToState(
    ValidateGuestUserEvent event,
  ) async* {
    if (event is ValidateGuestUserAuthenticationEvent) yield* _findGuestUser(event.userName, event.password);
  }

  Stream<ValidateGuestUserState> _findGuestUser(String aUserName, String aPassword) async* {
    yield ValidateGuestUserAuthenticating();
    try {
      // Production Code
      //--------------------------------------------------------------------------------------
      http.Response response = await _guestAPI.verifyGuestUser(aUserName, aPassword);
      if (response != null && response.body.isNotEmpty) {
        guestUserObj.copyFrom(GuestUserJsonModel.fromJson(json.decode(response.body) as Map<String, dynamic>));
        // guestUserObj.debug('Guest User Name : ${guestUserObj.userName} - Guest Display Name : ${guestUserObj.displayName}');
        if (guestUserObj.foundGuestUser) {
          GuestPersonDataModel resultPersonObj = GuestPersonDataModel();
          try {
            resultPersonObj.guestJsonObj.copyFrom(guestUserObj);
          } finally {
            currentGuestPerson = resultPersonObj;
            yield ValidateGuestUserFinishState();
          }
        } else
          yield ValidateGuestUserFailState();
      } else
        yield ValidateGuestUserFailState();
      //--------------------------------------------------------------------------------------

      // Testing code
      //--------------------------------------------------------------------------------------
      // guestUserObj.copyFrom(await _guestAPI.verifyGuestUser(aUserName, aPassword) as GuestUserJsonModel);
      // if (guestUserObj.foundGuestUser) {
      //   GuestPersonDataModel resultPersonObj = GuestPersonDataModel();
      //   try {
      //     resultPersonObj.guestJsonObj.copyFrom(guestUserObj);
      //   } finally {
      //     currentGuestPerson = resultPersonObj;
      //     yield ValidateGuestUserFinishState();
      //   }
      // } else
      //   yield ValidateGuestUserFailState();
      // print('$this.runtimeType - Found Guest User Result : ${guestUserObj.foundGuestUser}');
      //--------------------------------------------------------------------------------------
    } catch (error) {
      ValidateGuestUserError(error.toString());
    }
    //--------------------------------------------------------------------------------------
  }
}
