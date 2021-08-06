// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'get_soil_view.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// GetSoilView _$GetSoilViewFromJson(Map<String, dynamic> json) {
//   return GetSoilView(
//     idActivityProcess: json['idActivityProcess'] as int,
//     plot: json['plot'] as String,
//     idSoilType: json['idSoilType'] as int,
//     idSoilDetail: json['idSoilDetail'] as int,
//     soilDesc: json['soilDesc'],
//     no: json['no'] as int,
//     grooveSpace: json['grooveSpace'] as int,
//     fuelPrice: json['fuelPrice'] as int,
//     fuelAmount: json['fuelAmount'] as int,
//     tractorCost: json['tractorCost'] as int,
//     laborCost: json['laborCost'] as int,
//     date: json['date'] as String,
//     successStatus: json['successStatus'] as int,
//     date_format: json['date_format'] as String,
//     time_format: json['time_format'] as String,
//     has_one_soil_type: json['has_one_soil_type'] == null
//         ? null
//         : GetSoilViewType.fromJson(
//             json['has_one_soil_type'] as Map<String, dynamic>),
//     has_one_soil_detail: json['has_one_soil_detail'] == null
//         ? null
//         : GetSoilViewDetail.fromJson(
//             json['has_one_soil_detail'] as Map<String, dynamic>),
//     data: (json['data'] as List)
//         ?.map((e) => e == null
//             ? null
//             : GetSoilViewList.fromJson(e as Map<String, dynamic>))
//         ?.toList(),
//   );
// }

// Map<String, dynamic> _$GetSoilViewToJson(GetSoilView instance) =>
//     <String, dynamic>{
//       'idActivityProcess': instance.idActivityProcess,
//       'plot': instance.plot,
//       'idSoilType': instance.idSoilType,
//       'idSoilDetail': instance.idSoilDetail,
//       'soilDesc': instance.soilDesc,
//       'no': instance.no,
//       'grooveSpace': instance.grooveSpace,
//       'fuelPrice': instance.fuelPrice,
//       'fuelAmount': instance.fuelAmount,
//       'tractorCost': instance.tractorCost,
//       'laborCost': instance.laborCost,
//       'date': instance.date,
//       'successStatus': instance.successStatus,
//       'date_format': instance.date_format,
//       'time_format': instance.time_format,
//       'has_one_soil_type': instance.has_one_soil_type,
//       'has_one_soil_detail': instance.has_one_soil_detail,
//       'data': instance.data,
//     };
