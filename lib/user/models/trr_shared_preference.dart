import 'package:shared_preferences/shared_preferences.dart';
import '../../base_class/models/ai_base_model.dart';

import '../const.dart' as userCons;
import 'trr_preference_data.dart';

class TrrSharedPreference extends AiBasicItem {
  Future<SharedPreferences> _devicePreferencesObj = SharedPreferences.getInstance();
  static final TrrSharedPreference instance = TrrSharedPreference();

  Future<void> initial() async {
    // preference = await _getDevicePreference();
    _getDevicePreference();
  }

  Future<SharedPreferences> _getDevicePreference() async {
    return await _devicePreferencesObj;
  }

  Future<bool> saveToDeviceFrom(TrrPreferenceData aPreferenceData) async {
    var pref = await _getDevicePreference();
    if (aPreferenceData != null) {
      var obj = aPreferenceData;
      try {
        pref.setInt(userCons.kStoreUserID, obj.userID);
        pref.setInt(userCons.kStoreFactoryID, obj.factoryID);
        pref.setInt(userCons.kStoreUserEnrollID, obj.userEnrollID);
        pref.setString(userCons.kPasscode, obj.passcode);
        pref.setString(userCons.kDeviceToken, obj.deviceToken);
        pref.setBool(userCons.kIsSpecialUser, obj.isSpecialUser);
        pref.setInt(userCons.kStoreUserSpecialID, obj.userSpecialID);
        // print('${this.runtimeType} : Save preference complete');
        debug('Save preference complete');
        return true;
      } catch (error) {
        throw error;
      }
    } else
      return false;
  }

  Future<bool> exportDataTo(TrrPreferenceData aPreferenceData) async {
    // var pref = (_getDevicePreference() as SharedPreferences);
    var pref = await _getDevicePreference();
    if (aPreferenceData != null) {
      // Blank Data
      // ----------------------------------------------------------
      // aPreferenceData.userEnrollID = 0;
      // aPreferenceData.userID = 0;
      // aPreferenceData.factoryID = 0;
      // aPreferenceData.isSpecialUser = false;
      // aPreferenceData.passcode = '';
      // aPreferenceData.userSpecialID = 0;
      // ----------------------------------------------------------

      // Demo Data
      // ----------------------------------------------------------
      // aPreferenceData.userEnrollID = 1;
      // aPreferenceData.userID = 74;
      // aPreferenceData.factoryID = 1;
      // aPreferenceData.isSpecialUser = false;
      // aPreferenceData.passcode = '111111';
      // aPreferenceData.userSpecialID = 0;
      // ----------------------------------------------------------

      // Production code
      // ----------------------------------------------------------
      aPreferenceData.userEnrollID = pref.getInt(userCons.kStoreUserEnrollID) ?? 0; // > 0 is registered user
      aPreferenceData.userID = pref.getInt(userCons.kStoreUserID) ?? 0;
      aPreferenceData.factoryID = pref.getInt(userCons.kStoreFactoryID) ?? 0;
      aPreferenceData.isSpecialUser = pref.getBool(userCons.kIsSpecialUser) ?? false;
      aPreferenceData.passcode = pref.getString(userCons.kPasscode) ?? '';
      aPreferenceData.userSpecialID = pref.getInt(userCons.kStoreUserSpecialID) ?? 0;
      aPreferenceData.deviceToken = pref.getString(userCons.kDeviceToken) ?? '';
      // ----------------------------------------------------------
      return true;
    } else
      return false;
  }

  Future<void> clearDevicePreference() async {
    var _devicePref = await _getDevicePreference();
    if (_devicePref != null) {
      try {
        _devicePref.setInt(userCons.kStoreUserID, 0);
        _devicePref.setInt(userCons.kStoreFactoryID, 0);
        _devicePref.setInt(userCons.kStoreUserEnrollID, 0);
        _devicePref.setString(userCons.kPasscode, '');
        _devicePref.setString(userCons.kDeviceToken, '');
        _devicePref.setBool(userCons.kIsSpecialUser, false);
        _devicePref.setInt(userCons.kStoreUserSpecialID, 0);
        debug('Clear Device Preference Success.');
      } catch (error) {
        throw error;
      }
    }
  }
}

/* ------------------------------------------------------------------ */
