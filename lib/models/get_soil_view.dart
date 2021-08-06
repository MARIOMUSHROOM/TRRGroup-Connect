// import 'package:ai_flutter/models/get_soil_view_detail.dart';
// import 'package:ai_flutter/models/get_soil_view_list.dart';
// import 'package:ai_flutter/models/get_soil_view_type.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'get_soil_view.g.dart';

// @JsonSerializable()
// class GetSoilView {
//   GetSoilView({
//     this.idActivityProcess,
//     this.plot,
//     this.idSoilType,
//     this.idSoilDetail,
//     this.soilDesc,
//     this.no,
//     this.grooveSpace,
//     this.fuelPrice,
//     this.fuelAmount,
//     this.tractorCost,
//     this.laborCost,
//     this.date,
//     this.successStatus,
//     this.date_format,
//     this.time_format,
//     this.has_one_soil_type,
//     this.has_one_soil_detail,
//     this.data,
//   });

//   final int idActivityProcess;
//   final String plot;
//   final int idSoilType;
//   final int idSoilDetail;
//   final dynamic soilDesc;
//   final int no;
//   final int grooveSpace;
//   final int fuelPrice;
//   final int fuelAmount;
//   final int tractorCost;
//   final int laborCost;
//   final String date;
//   final int successStatus;
//   final String date_format;
//   final String time_format;
//   final GetSoilViewType has_one_soil_type;
//   final GetSoilViewDetail has_one_soil_detail;
//   final List<GetSoilViewList> data;

//   factory GetSoilView.fromJson(Map<String, dynamic> json) =>
//       _$GetSoilViewFromJson(json);

//   /// `toJson` is the convention for a class to declare support for serialization
//   /// to JSON. The implementation simply calls the private, generated
//   /// helper method `_$GetSoilViewToJson`.
//   Map<String, dynamic> toJson() => _$GetSoilViewToJson(this);
// }
