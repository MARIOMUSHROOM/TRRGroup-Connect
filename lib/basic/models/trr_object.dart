// import 'package:flutter/material.dart';
import '../../base_class/models/ai_base_model.dart';

import '../../user/models/trr_user_model.dart';
import '../../user/models/person_data_model.dart';
import '../../user/models/trr_preference_data.dart';

class TrrData extends AiBasicItem {
  static final TrrData instance = TrrData(); //Global instance of Trr data

  TrrBasicUser _userDataObj;
  TrrBasicUser get userDataObj {
    if (_userDataObj == null) _userDataObj = TrrBasicUser();
    return _userDataObj;
  }

  void generateUserObjByPersonData(BasicPersonDataModel aCurrentPersonObj, TrrPreferenceData aPreferenceDataObj) {
    if (aCurrentPersonObj != null) {
      var resUserObj;
      if (aCurrentPersonObj.runtimeType == NormalPersonDataModel)
        resUserObj = TrrGeneralUser();
      else if (aCurrentPersonObj.runtimeType == SpecialPersonfDataModel)
        resUserObj = TrrSpecialUser();
      else if (aCurrentPersonObj.runtimeType == GuestPersonDataModel) resUserObj = TrrGuestUser();

      try {
        resUserObj.initial(aCurrentPersonObj, aPreferenceDataObj);
      } finally {
        _userDataObj = resUserObj;
        debug('${_userDataObj.runtimeType} ${_userDataObj.profileName}');
      }
    }
  }
}

/* ------------------------------------------------------------------ */
// class TrrUser extends AiBasicItem with AiHttpItemLoaderMixin {
//   int quotaID; // = idUser = quota_no
//   int factoryID; // = mill_no = idFactory
//   String firstName;
//   String lastName;
//   String idCardNumber;
//   String contractNumber;
//   String caneOfficeNumber; // Office of the cane and sugar board number
//   String phoneNumber;
//   String address;
//   String photoUrl; // URL for user photo

//   String get fullName => '$firstName $lastName';

//   TrrUser({
//     int id,
//     this.quotaID,
//     this.firstName,
//     this.lastName,
//     this.idCardNumber,
//     this.contractNumber,
//     this.caneOfficeNumber,
//     this.phoneNumber,
//     this.address,
//     this.photoUrl,
//     this.factoryID,
//   }) : super(id: id);

//   static TrrUser dummyData = TrrUser(
//     quotaID: 36,
//     firstName: 'กฤษฎา',
//     lastName: 'สังขีด',
//     idCardNumber: '1212342323442',
//     contractNumber: 'TRR 3322 3332',
//     caneOfficeNumber: '2324566467',
//     phoneNumber: '089-992-9849',
//     address: '25 ถ.สาทรใต้ แขวง ทุ่งมหาเมฆ เขต สาทร กรุงเทพมหานคร 10120',
//     photoUrl: 'https://i.pravatar.cc/150?img=6',
//     factoryID: 2,
//     // photoUrl: '',
//   );
// }
