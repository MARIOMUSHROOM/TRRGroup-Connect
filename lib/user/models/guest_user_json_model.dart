// To parse this JSON data, do
//
//     final guestUserJsonModel = guestUserJsonModelFromJson(jsonString);

import 'dart:convert';
import '../../base_class/models/ai_base_model.dart';

const kFieldUserGuestID = "idUserGuest";
const kFieldUserName = "userName";
const kFieldDisplayName = "displayName";
const kFieldStatus = "status";
const kFieldStatusMessage = "status_message";
const kFieldError = "error";

GuestUserJsonModel guestUserJsonModelFromJson(String str) => GuestUserJsonModel.fromJson(json.decode(str));
String guestUserJsonModelToJson(GuestUserJsonModel data) => json.encode(data.toJson());

class GuestUserJsonModel extends AiBasicItem {
  GuestUserJsonModel({
    this.idUserGuest = 0,
    this.userName = '',
    this.displayName = '',
    this.status = 0,
    this.statusMessage = '',
  });

  int idUserGuest;
  String userName;
  String displayName;
  int status;
  String statusMessage;

  factory GuestUserJsonModel.fromJson(Map<String, dynamic> json) => GuestUserJsonModel(
        idUserGuest: json[kFieldUserGuestID] == null ? 0 : json[kFieldUserGuestID],
        userName: json[kFieldUserName] == null ? '' : json[kFieldUserName],
        displayName: json[kFieldDisplayName] == null ? '' : json[kFieldDisplayName],
        status: json[kFieldStatus] == null ? 0 : json[kFieldStatus],
        statusMessage: json[kFieldStatusMessage] == null ? '' : json[kFieldStatusMessage],
      );

  Map<String, dynamic> toJson() => {
        kFieldUserGuestID: idUserGuest == 0 ? null : idUserGuest,
        kFieldUserName: userName == '' ? null : userName,
        kFieldDisplayName: displayName == '' ? null : displayName,
      };

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    GuestUserJsonModel s = aSource as GuestUserJsonModel;
    idUserGuest = s.idUserGuest;
    userName = s.userName;
    displayName = s.displayName;
    status = s.status;
    statusMessage = s.statusMessage;
  }

  bool get foundGuestUser => idUserGuest > 0;

  static final GuestUserJsonModel instance = GuestUserJsonModel();
}
