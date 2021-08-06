import '../../base_class/models/ai_base_model.dart';
import 'dart:convert';

// To parse this JSON data, do
//     final specialUserDataModel = specialUserDataModelFromJson(jsonString);

SpecialUserJsonModel specialUserJsonModelFromJson(String str) => SpecialUserJsonModel.fromJson(json.decode(str));
String specialUserJsonModelToJson(SpecialUserJsonModel data) => json.encode(data.toJson());

class SpecialUserJsonModel extends AiBasicItem {
  SpecialUserJsonModel({
    this.idUserSpecial = 0,
    this.idUser = 0,
    this.idFactory = 0,
    this.firstName = '',
    this.lastName = '',
    this.idCardNumber = '',
    this.phoneNumber = '',
  });

  int idUserSpecial;
  int idUser;
  int idFactory;
  String firstName;
  String lastName;
  String idCardNumber;
  String phoneNumber;

  @override
  void internalCopyFrom(dynamic aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as SpecialUserJsonModel;
    this.idUserSpecial = s.idUserSpecial;
    this.idUser = s.idUser;
    this.idFactory = s.idFactory;
    this.firstName = s.firstName;
    this.lastName = s.lastName;
    this.idCardNumber = s.idCardNumber;
    this.phoneNumber = s.phoneNumber;
  }

  static final SpecialUserJsonModel instance = SpecialUserJsonModel();

  bool get isSpecialUser => this.idUserSpecial > 0;
  String get fullName => '$firstName $lastName';

  factory SpecialUserJsonModel.fromJson(Map<String, dynamic> json) => SpecialUserJsonModel(
        idUserSpecial: json["idUserSpecial"] == null ? 0 : json["idUserSpecial"],
        idUser: json["idUser"] == null ? 0 : json["idUser"],
        idFactory: json["idFactory"] == null ? 0 : json["idFactory"],
        firstName: json["firstName"] == null ? '' : json["firstName"],
        lastName: json["lastName"] == null ? '' : json["lastName"],
        idCardNumber: json["idCardNumber"] == null ? '' : json["idCardNumber"],
        phoneNumber: json["phoneNumber"] == null ? '' : json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "idUserSpecial": idUserSpecial == null ? null : idUserSpecial,
        "idUser": idUser == null ? null : idUser,
        "idFactory": idFactory == null ? null : idFactory,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "idCardNumber": idCardNumber == null ? null : idCardNumber,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
      };
}
