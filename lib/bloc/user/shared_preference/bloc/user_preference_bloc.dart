import 'dart:async';

// import 'package:ai_flutter/user/models/trr_shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../user/models/trr_preference_data.dart';
import '../../../../user/providers/trr_shared_preference_provider.dart';

part 'user_preference_event.dart';
part 'user_preference_state.dart';

class UserPreferenceBloc extends Bloc<UserPreferenceEvent, UserPreferenceState> {
  UserPreferenceBloc() : super(UserPreferenceInitial());

  // TrrPreferenceData preferenceData = TrrPreferenceData.instance;

  @override
  Stream<UserPreferenceState> mapEventToState(
    UserPreferenceEvent event,
  ) async* {
    if (event is UserPreferenceRequestDevicePreferenceEvent)
      yield* _doLoadPreference(event.preferenceData);
    else if (event is UserPreferenceSaveToDevicePreferenceEvent)
      yield* _doSavePreference(event.updatePreferenceData);
    else if (event is UserPreferenceClearDevicePreferenceEvent) yield* _doClearPreference();
  }

  Stream<UserPreferenceState> _doLoadPreference(TrrPreferenceData aPreferenceData) async* {
    yield UserPreferenceLoading();
    try {
      var loadResult = await TrrSharedPreferenceProvider().loadPreference(aPreferenceData);
      if (loadResult)
        yield UserPreferenceLoadFinished();
      else
        yield UserPreferenceNoData();
    } catch (error) {
      yield UserPreferenceError(error.toString());
    }
  }

  Stream<UserPreferenceState> _doSavePreference(TrrPreferenceData aSourcePreferenceData) async* {
    yield SavingUserPreference();
    try {
      var saveResult = await TrrSharedPreferenceProvider().savePreference(aSourcePreferenceData);
      if (saveResult)
        yield SaveUserPreferenceComplete();
      else
        yield SaveUserPreferenceFail();
    } catch (error) {
      yield SaveUserPreferenceError(error.toString());
    }
  }

  Stream<UserPreferenceState> _doClearPreference() async* {
    yield ClearingDevicePreferenceState();
    try {
      try {
        await TrrSharedPreferenceProvider().clearDevicePreference();
      } finally {
        yield ClearPreferenceSuccesState();
      }
    } catch (error) {
      yield ClearPreferenceFailState();
    }
  }
}
