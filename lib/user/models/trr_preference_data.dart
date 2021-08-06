import '../../base_class/models/ai_base_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class TrrPreferenceData extends AiBasicItem {
  final FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;

  int userID; // idUser - link to TRR Backend
  int factoryID; // idFactory - link to TRR Backend
  int userEnrollID; // idUserEntroll - link to AI Backend
  String passcode;
  String deviceToken;
  bool isSpecialUser;
  int userSpecialID; // using when the object walk trough register process
  String inputIDCardNumber;

  Future<void> retrieveDeviceToken() async {
    deviceToken = await _firebaseMessage.getToken();
    debug('Device token : $deviceToken');
  }

  TrrPreferenceData({
    this.userID = 0,
    this.factoryID = 0,
    this.userEnrollID = 0,
    this.passcode = '',
    this.deviceToken = '',
    this.isSpecialUser = false,
    this.userSpecialID = 0,
    this.inputIDCardNumber = '',
  });

  @override
  void internalCopyFrom(dynamic aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as TrrPreferenceData;
    userID = s.userID;
    factoryID = s.factoryID;
    userEnrollID = s.userEnrollID;
    passcode = s.passcode;
    deviceToken = s.deviceToken;
    isSpecialUser = s.isSpecialUser;
    userSpecialID = s.userSpecialID;
    inputIDCardNumber = s.inputIDCardNumber;
  }

  bool get isAlreadyEnroll => userEnrollID > 0;

  static final TrrPreferenceData instance = TrrPreferenceData();

  Map<String, dynamic> toJsonDataForEnroll() => {
        "idUser": userID == null ? null : userID,
        "idFactory": factoryID == null ? null : factoryID,
        "idCardNumber": inputIDCardNumber == null ? null : inputIDCardNumber,
        "isSpecialUser": isSpecialUser == null ? null : isSpecialUser,
        "deviceToken": deviceToken == null ? null : deviceToken,
      };

  String get toPostString => '$userID/$factoryID/$isSpecialUser/$inputIDCardNumber/$deviceToken';
}
