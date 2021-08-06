import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../user/models/validate_user_model.dart';
import '../../../../provider/user_api.dart';
import '../../../../user/models/special_user_json_model.dart';

part 'validate_user_event.dart';
part 'validate_user_state.dart';

enum ValidateUserBlocRunningFlag {
  Idle,
  AlreadyCheckedNormalUser,
  AlreadyCheckedSpecialUser,
}

class ValidateUserBloc extends Bloc<ValidateUserEvent, ValidateUserState> {
  ValidateUserBloc() : super(ValidateUserInitial());

  bool isFoundNormalUser = false;
  bool isFoundSpecialUser = false;
  ValidateUserBlocRunningFlag runningFlag = ValidateUserBlocRunningFlag.Idle;

  // User data object
  final TrrValidateUser validateNormalUserObj = TrrValidateUser.instance;
  final SpecialUserJsonModel validateSpecialUserObj = SpecialUserJsonModel.instance;

  // API object
  final ValidateUserAPI _userApiObj = ValidateUserAPI.instance;

  @override
  Stream<ValidateUserState> mapEventToState(
    ValidateUserEvent event,
  ) async* {
    isFoundNormalUser = false;
    isFoundSpecialUser = false;

    if (event is ValidateUserCheckExistingUserEvent)
      // check for existing normal TRR user
      yield* _findExistingTrrUser(event.idCard, event.phoneNumber);
    else if (event is ValidateUserCheckExistingSpecialUserEvent)
      // check for special user in user_special table
      yield* _findSpecialUser(event.idCard, event.phoneNumber);
  }

  // find existing user by asking from TRR API
  Stream<ValidateUserState> _findExistingTrrUser(String aIDCard, String aPhoneNumber) async* {
    yield ValidateUserLoadingState();
    try {
      // Change sequential running flag
      runningFlag = ValidateUserBlocRunningFlag.AlreadyCheckedNormalUser;

      // // Production code (works)
      //------------------------------------------------------------------------------------------------
      http.Response result = await _userApiObj.findTrrUser(aIDCard, aPhoneNumber);
      if (result != null && result.body.isNotEmpty) {
        // result.body will be Map<String, dynamic>
        validateNormalUserObj.copyFrom(TrrValidateUser.fromJson(json.decode(result.body) as Map<String, dynamic>));
        isFoundNormalUser = validateNormalUserObj.validateResult == ValidateUserResult.FoundUser;
        runningFlag = ValidateUserBlocRunningFlag.AlreadyCheckedNormalUser;
        // print('$runtimeType ${validateNormalUserObj.quotaId} ${validateNormalUserObj.factoryId}');
        yield ValidateUserLoadFinishedState();
      } else
        yield ValidateUserEmptyState();
      //------------------------------------------------------------------------------------------------

      // Test code
      //------------------------------------------------------------------------------------------------
      // TrrValidateUser resultObj = await _userApiObj.findTrrUser(aIDCard, aPhoneNumber);
      // if (resultObj != null) {
      //   validateNormalUserObj.copyFrom(resultObj);
      //   // change running flag
      //   isFoundNormalUser = resultObj.validateResult == ValidateUserResult.FoundUser;
      //   if (isFoundNormalUser)
      //     print('${this.runtimeType} Found normal TRR User : userID : ${resultObj.quotaId} : factoryid : ${resultObj.factoryId}');
      //   else
      //     print('${this.runtimeType} TRR Normal User Not Found');
      //   yield ValidateUserLoadFinishedState();
      // } else
      //   yield ValidateUserEmptyState();
      //------------------------------------------------------------------------------------------------
      // End testing section

    } catch (error) {
      yield ValidateUserErrorState(error.toString());
    }
  }

  // find special user in user_special table
  Stream<ValidateUserState> _findSpecialUser(String aIDCard, String aPhoneNumber) async* {
    yield ValidateUserLoadingState();
    try {
      // Change sequential running flag
      runningFlag = ValidateUserBlocRunningFlag.AlreadyCheckedSpecialUser;

      // Production code
      //------------------------------------------------------------------------------------------------
      http.Response response = await _userApiObj.findSpecialUser(aIDCard, aPhoneNumber);
      if (response != null && response.body.isNotEmpty) {
        validateSpecialUserObj.copyFrom(SpecialUserJsonModel.fromJson(json.decode(response.body) as Map<String, dynamic>));
        // if found special user data in user_special table
        this.isFoundSpecialUser = validateSpecialUserObj.isSpecialUser;
        yield ValidateUserLoadFinishedState();
      } else
        yield ValidateUserEmptyState();
      //------------------------------------------------------------------------------------------------

      // Testing code
      //------------------------------------------------------------------------------------------------
      // SpecialUserJsonModel specialUser = await _userApiObj.findSpecialUser(aIDCard, aPhoneNumber);
      // if (specialUser != null) {
      //   validateSpecialUserObj.copyFrom(specialUser);
      //   // if found special user data in user_special table
      //   this.isFoundSpecialUser = validateSpecialUserObj.isSpecialUser;
      //   if (this.isFoundSpecialUser)
      //     print('${this.runtimeType} Found Special User id card : ${specialUser.phoneNumber}');
      //   else
      //     print('${this.runtimeType} : Not found any of users...');
      //   yield ValidateUserLoadFinishedState();
      // } else
      //   yield ValidateUserEmptyState();
      //------------------------------------------------------------------------------------------------
      // end of testing code

    } catch (error) {
      yield ValidateUserErrorState(error.toString());
    }
  }
}
