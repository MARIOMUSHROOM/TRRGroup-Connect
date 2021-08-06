import 'package:ai_flutter/bloc/user/validate_user/bloc/validate_user_bloc.dart';
import 'package:ai_flutter/user/models/person_data_model.dart';
import 'package:ai_flutter/user/models/special_user_json_model.dart';

import '../../base_class/models/ai_base_model.dart';
import 'package:flutter/cupertino.dart';
import '../../global_utils.dart' as util;
import './trr_preference_data.dart';
import '../../profile/models/profile_json_model.dart';
import './menu_action_permission_model.dart';

/* ------------------------------------------------------------------ */
enum TrrUserType {
  General,
  Guest,
  Special,
}

// Basic class of TRR User
class TrrBasicUser extends AiBasicItem {
  int userEnrollID = 0;
  int userID = 0; // QuotaID in TRR system
  int factoryID = 0; // FacID

  int get aiUserID => userEnrollID;
  int get quotaID => userID;
  int get millNo => factoryID;
  int get facID => this.millNo;

  // connect menu accessible permission object
  BasicMenuActionPermissionModel _menuPermissionObj;

  @protected
  BasicMenuActionPermissionModel internalGetActionPermission() => BasicMenuActionPermissionModel();

  @protected
  TrrUserType getUserType() => TrrUserType.General;
  TrrUserType get userType => this.getUserType();

  @protected
  String userProfileName = '';
  @protected
  String internalGetProfileName() => userProfileName;
  String get profileName => internalGetProfileName();

  @protected
  String userDisplayName = '';
  @protected
  String internalGetDisplayName() => userDisplayName;
  String get displayName => internalGetDisplayName();

  @protected
  void internalInitial(BasicPersonDataModel aPersonObj, TrrPreferenceData aPreferenceDataObj) {}

  @protected
  bool internalIsValidPersonObj(BasicPersonDataModel aPersonObj) => false;

  void initial(BasicPersonDataModel aPersonObj, TrrPreferenceData aPreferenceDataObj) {
    if (aPersonObj != null && aPreferenceDataObj != null && internalIsValidPersonObj(aPersonObj))
      internalInitial(
        aPersonObj,
        aPreferenceDataObj,
      );
  }

  BasicMenuActionPermissionModel get menuPermission {
    if (_menuPermissionObj == null) _menuPermissionObj = internalGetActionPermission();
    return _menuPermissionObj;
  }
}

/* ------------------------------------------------------------------ */
// Guest User
class TrrGuestUser extends TrrBasicUser {
  @override
  TrrUserType getUserType() => TrrUserType.Guest;

  @override
  bool internalIsValidPersonObj(BasicPersonDataModel aPersonObj) => aPersonObj.runtimeType == GuestPersonDataModel;

  @override
  void internalInitial(BasicPersonDataModel aPersonObj, TrrPreferenceData aPreferenceDataObj) {
    GuestPersonDataModel guestObj = aPersonObj as GuestPersonDataModel;
    userDisplayName = guestObj.guestJsonObj.displayName;
    userProfileName = userDisplayName;
  }

  @override
  BasicMenuActionPermissionModel internalGetActionPermission() => GuestUserMenuActionPermissionModel();
}

/* ------------------------------------------------------------------ */
// General User
class TrrGeneralUser extends TrrBasicUser {
  final ProfileJsonModel profileObj = ProfileJsonModel();

  @override
  String internalGetProfileName() => profileObj.fullName;

  @override
  String internalGetDisplayName() => this.profileName;

  @override
  TrrUserType getUserType() => TrrUserType.General;

  @override
  bool internalIsValidPersonObj(BasicPersonDataModel aPersonObj) => aPersonObj.runtimeType == NormalPersonDataModel;

  @override
  void internalInitial(BasicPersonDataModel aPersonObj, TrrPreferenceData aPreferenceDataObj) {
    var normalPerson = aPersonObj as NormalPersonDataModel;
    profileObj.copyFrom(normalPerson.profileJsonObj);

    userID = aPreferenceDataObj.userID;
    userEnrollID = aPreferenceDataObj.userEnrollID;
    factoryID = aPreferenceDataObj.factoryID;
  }

  @override
  BasicMenuActionPermissionModel internalGetActionPermission() => GeneralUserMenuActionPermissionModel();
}

/* ------------------------------------------------------------------ */
// Special User
class TrrSpecialUser extends TrrGeneralUser {
  int userSpecialID = 0;

  @override
  TrrUserType getUserType() => TrrUserType.Special;

  @override
  bool internalIsValidPersonObj(BasicPersonDataModel aPersonObj) => aPersonObj.runtimeType == SpecialPersonfDataModel;

  @override
  String internalGetDisplayName() => this.userDisplayName;

  @override
  void internalInitial(BasicPersonDataModel aPersonObj, TrrPreferenceData aPreferenceDataObj) {
    super.internalInitial(aPersonObj, aPreferenceDataObj);
    SpecialUserJsonModel sObj = (aPersonObj as SpecialPersonfDataModel).specialJsonObj;
    this.userSpecialID = sObj.idUserSpecial;
    this.userDisplayName = sObj.fullName;
  }
}
