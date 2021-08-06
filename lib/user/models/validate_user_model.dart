import '../../base_class/models/ai_base_model.dart';
import 'dart:convert';

enum ValidateUserResult {
  UserNotFound,
  FoundUser,
  UnknownError, // = 2
}

// To parse this JSON data, do
//
//     final trrValidateUser = trrValidateUserFromJson(jsonString);

TrrValidateUser trrValidateUserFromJson(String str) => TrrValidateUser.fromJson(json.decode(str));
String trrValidateUserToJson(TrrValidateUser data) => json.encode(data.toJson());

/* Data return from API */
/*
{
    "result": 1,
    "quota_id": 74,
    "user_type": 0,
    "factory_id": 1
}
 */

class TrrValidateUser extends AiBasicItem {
  TrrValidateUser({
    this.result = 2,
    this.quotaId = 0,
    this.factoryId = 0,
    this.userType = 0,
  });

  int result;
  int quotaId;
  int factoryId;
  int userType;

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as TrrValidateUser;
    result = s.result;
    quotaId = s.quotaId;
    factoryId = s.factoryId;
    userType = s.userType;
  }

  static final TrrValidateUser instance = TrrValidateUser();

  ValidateUserResult get validateResult => ValidateUserResult.values[this.result];

  factory TrrValidateUser.fromJson(Map<String, dynamic> json) => TrrValidateUser(
        result: json["result"] == null ? 0 : json["result"],
        quotaId: json["quota_id"] == null ? 0 : json["quota_id"],
        factoryId: json["factory_id"] == null ? 0 : json["factory_id"],
        userType: json["user_type"] == null ? 0 : json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "quota_id": quotaId == null ? null : quotaId,
        "factory_id": factoryId == null ? null : factoryId,
        "user_type": userType == null ? null : userType,
      };
}

//=======================================================================================================================================
// To parse this JSON data, do
//
//     final enrollUserResultModel = enrollUserResultModelFromJson(jsonString);

EnrollUserResultModel enrollUserResultModelFromJson(String str) => EnrollUserResultModel.fromJson(json.decode(str));
String enrollUserResultModelToJson(EnrollUserResultModel data) => json.encode(data.toJson());

class EnrollUserResultModel extends AiBasicItem {
  int idUserEnroll;

  EnrollUserResultModel({
    this.idUserEnroll = 0,
  });

  @override
  void internalCopyFrom(dynamic aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as EnrollUserResultModel;
    idUserEnroll = s.idUserEnroll;
  }

  bool get isEnrollUserExist => idUserEnroll > 0;

  factory EnrollUserResultModel.fromJson(Map<String, dynamic> json) => EnrollUserResultModel(
        idUserEnroll: json["idUserEnroll"] == null ? 0 : json["idUserEnroll"],
      );

  Map<String, dynamic> toJson() => {
        "idUserEnroll": idUserEnroll == null ? 0 : idUserEnroll,
      };
}
