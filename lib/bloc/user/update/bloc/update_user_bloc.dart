import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../user/models/trr_preference_data.dart';
import '../../../../provider/user_api.dart';
import '../../../../user/models/validate_user_model.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  UpdateUserBloc() : super(UpdateUserInitial());

  UpdateUserDataAPI _updateUserApi = UpdateUserDataAPI.instance;

  int newUserEnrollID = 0;
  bool get isEnrollNewUserSuccess => newUserEnrollID > 0;

  @override
  Stream<UpdateUserState> mapEventToState(
    UpdateUserEvent event,
  ) async* {
    if (event is UpdateUserEnrollNewUserEvent) yield* _addNewUser(event.mainPreferenceData);
    // else if (event is UpdateUserResetStateEvent) yield UpdateUserInitial();
  }

  Stream<UpdateUserState> _addNewUser(TrrPreferenceData aMainPreferenceData) async* {
    // updating / update complete / update fail / update error because connection
    yield UpdatingNewUser();
    try {
      // Production code
      http.Response response = await _updateUserApi.enrollUser(aMainPreferenceData);
      if (response != null && response.body.isNotEmpty) {
        var enrollUserResultObj = EnrollUserResultModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
        newUserEnrollID = enrollUserResultObj.idUserEnroll;
        if (isEnrollNewUserSuccess)
          yield UpdateNewUserComplete();
        else
          yield UpdateNewUserFail();
      } else
        yield UpdateNewUserFail();

      // Testing code
      // EnrollUserResultModel testObj = await _updateUserApi.enrollUser(aMainPreferenceData);
      // if (testObj != null) {
      //   newUserEnrollID = testObj.idUserEnroll;
      //   if (isEnrollNewUserSuccess)
      //     yield UpdateNewUserComplete();
      //   else
      //     yield UpdateNewUserFail();
      // }
      //-----------------------------------------------------------
    } catch (error) {
      yield UpdateNewUserError(error.toString());
    }
  }
}
