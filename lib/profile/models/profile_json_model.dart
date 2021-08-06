// To parse this JSON data, do
//
//     final profileJsonModel = profileJsonModelFromJson(jsonString);

import 'dart:convert';
import '../../base_class/models/ai_base_model.dart';

ProfileJsonModel profileJsonModelFromJson(String str) => ProfileJsonModel.fromJson(json.decode(str));

String profileJsonModelToJson(ProfileJsonModel data) => json.encode(data.toJson());

enum ProfileFoundResult {
  ProfileNotFound, // 0
  FoundProfile, // 1
  UnknownError // 2
}

class ProfileJsonModel extends AiBasicItem {
  ProfileJsonModel({
    this.result = 2,
    this.firstName = '',
    this.lastName = '',
    this.idNumber = '',
    this.idReference = 0,
    this.officeSugarcaneId = '',
    this.phoneNumber = '',
    this.address = '',
    this.data,
  });

  int result;
  String firstName;
  String lastName;
  String idNumber;
  int idReference;
  String officeSugarcaneId;
  String phoneNumber;
  String address;
  List<DataYearItem> data;
  // framework property
  DataYearList _dataYearList;

  DataYearList get dataYearList {
    if (_dataYearList == null) _dataYearList = DataYearList();
    return _dataYearList;
  }

  set dataYearList(DataYearList value) {}

  String get fullName => '$firstName $lastName';

  ProfileFoundResult get profileFoundResult => ProfileFoundResult.values[this.result];

  factory ProfileJsonModel.fromJson(Map<String, dynamic> json) => ProfileJsonModel(
        result: json["result"] == null ? 2 : json["result"],
        firstName: json["first_name"] == null ? '' : json["first_name"],
        lastName: json["last_name"] == null ? '' : json["last_name"],
        idNumber: json["id_number"] == null ? '' : json["id_number"],
        idReference: json["id_reference"] == null ? 0 : json["id_reference"],
        officeSugarcaneId: json["office_sugarcane_id"] == null ? '' : json["office_sugarcane_id"],
        phoneNumber: json["phone_number"] == null ? '' : json["phone_number"],
        address: json["address"] == null ? '' : json["address"],
        data: json["data"] == null ? [] : List<DataYearItem>.from(json["data"].map((x) => DataYearItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "id_number": idNumber == null ? null : idNumber,
        "id_reference": idReference == null ? null : idReference,
        "office_sugarcane_id": officeSugarcaneId == null ? null : officeSugarcaneId,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "address": address == null ? null : address,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  void internalCopyFrom(aSource) {
    var s = aSource as ProfileJsonModel;
    result = s.result;
    firstName = s.firstName;
    lastName = s.lastName;
    idNumber = s.idNumber;
    idReference = s.idReference;
    officeSugarcaneId = s.officeSugarcaneId;
    phoneNumber = s.phoneNumber;
    address = s.address;
    if (s.data != null && s.data.isNotEmpty)
      dataYearList.copyFromList(s.data);
    else
      dataYearList.cloneFrom(s.dataYearList);
  }
}

class DataYearList extends AiBasicList {
  @override
  List<AiBaseItem> getObjList() => <DataYearItem>[];

  @override
  AiBaseItem getNewObjItem() => DataYearItem();

  void copyFromList(List aSourceList) {
    if (aSourceList != null && aSourceList.isNotEmpty) {
      clear();
      aSourceList.forEach((element) {
        this.addItem(DataYearItem()..copyFrom(element));
      });
    }
  }
}

class DataYearItem extends AiBasicItem {
  DataYearItem({
    this.agricultureYear = '',
    this.ccsMean = 0.0,
    this.product = 0.0,
    this.productRef = 0.0,
    this.stationTotal = 0,
    this.areaTotal = 0.0,
    this.areaGets = 0.0,
    this.areaBonsucro = 0.0,
    this.estimateProduct = 0.0,
  });

  String agricultureYear;
  double ccsMean;
  double product;
  double productRef;
  int stationTotal;
  double areaTotal;
  double areaGets;
  double areaBonsucro;
  double estimateProduct;

  factory DataYearItem.fromJson(Map<String, dynamic> json) => DataYearItem(
        agricultureYear: json["agriculture_year"] == null ? '' : json["agriculture_year"],
        ccsMean: json["ccs_mean"] == null ? 0.0 : json["ccs_mean"].toDouble(),
        product: json["product"] == null ? 0.0 : json["product"].toDouble(),
        productRef: json["product_ref"] == null ? 0.0 : json["product_ref"].toDouble(),
        stationTotal: json["station_total"] == null ? 0 : json["station_total"],
        areaTotal: json["area_total"] == null ? 0.0 : json["area_total"].toDouble(),
        areaGets: json["area_gets"] == null ? 0.0 : json["area_gets"].toDouble(),
        areaBonsucro: json["area_bonsucro"] == null ? 0.0 : json["area_bonsucro"].toDouble(),
        estimateProduct: json["estimate_product"] == null ? 0.0 : json["estimate_product"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "agriculture_year": agricultureYear == null ? null : agricultureYear,
        "ccs_mean": ccsMean == null ? null : ccsMean,
        "product": product == null ? null : product,
        "product_ref": productRef == null ? null : productRef,
        "station_total": stationTotal == null ? null : stationTotal,
        "area_total": areaTotal == null ? null : areaTotal,
        "area_gets": areaGets == null ? null : areaGets,
        "area_bonsucro": areaBonsucro == null ? null : areaBonsucro,
        "estimate_product": estimateProduct == null ? null : estimateProduct,
      };

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    DataYearItem s = aSource as DataYearItem;
    agricultureYear = s.agricultureYear;
    ccsMean = s.ccsMean;
    product = s.product;
    productRef = s.productRef;
    stationTotal = s.stationTotal;
    areaTotal = s.areaTotal;
    areaGets = s.areaGets;
    areaBonsucro = s.areaBonsucro;
    estimateProduct = s.estimateProduct;
  }
}
