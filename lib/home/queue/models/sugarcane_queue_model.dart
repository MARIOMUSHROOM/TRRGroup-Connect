import '../queue_const.dart';

import 'sugarcane_type_truck_model.dart';

class SugarcaneQueueModel {
  // id should be int or string
  DateTime queueDateTime = DateTime.now();
  String factoryName;
  int overallTruckCount;
  int workingTruckCount;
  List<SugarcaneTypeTruckModel> internalCourtYard = [];
  List<SugarcaneTypeTruckModel> externalCourtYard = [];

  SugarcaneQueueModel({
    this.factoryName,
    this.overallTruckCount,
    this.workingTruckCount,
    this.internalCourtYard,
    this.externalCourtYard,
  });

  DateTime get queueDate => queueDateTime;
  DateTime get queueTime => queueDateTime;

  int _getInternalCourtTruckCount() {
    var result = 0;
    for (var i = 0; i < internalCourtYard.length; i++) result += internalCourtYard[i].truckCount;
    return result;
  }

  int _getExternalCourtTruckCount() {
    var result = 0;
    for (var i = 0; i < externalCourtYard.length; i++) result += externalCourtYard[i].truckCount;
    return result;
  }

  int get internalCourtTruckSummary => _getInternalCourtTruckCount();
  int get externalCourtTruckSummary => _getExternalCourtTruckCount();

  static SugarcaneQueueModel instance = SugarcaneQueueModel(
    factoryName: 'บริษัท น้ำตาลสระบุรี จำกัด (วังม่วง)',
    overallTruckCount: 683,
    workingTruckCount: 679,
    internalCourtYard: [
      (SugarcaneTypeTruckModel(
        sugarCaneTypeName: 'อ้อยไฟไหม้',
        sugarcaneType: QueueSugarcaneType.BurnedSugarcane,
        truckCount: 1,
      )),
      (SugarcaneTypeTruckModel(
        sugarCaneTypeName: 'อ้อยท่อน',
        sugarcaneType: QueueSugarcaneType.SugarcanePiece,
        truckCount: 1,
      )),
      (SugarcaneTypeTruckModel(
        sugarCaneTypeName: 'อ้อยสด',
        sugarcaneType: QueueSugarcaneType.FreshSugarcane,
        truckCount: 0,
      )),
    ],
    externalCourtYard: [
      (SugarcaneTypeTruckModel(
        sugarCaneTypeName: 'อ้อยไฟไหม้',
        sugarcaneType: QueueSugarcaneType.BurnedSugarcane,
        truckCount: 0,
      )),
      (SugarcaneTypeTruckModel(
        sugarCaneTypeName: 'อ้อยท่อน',
        sugarcaneType: QueueSugarcaneType.SugarcanePiece,
        truckCount: 0,
      )),
      (SugarcaneTypeTruckModel(
        sugarCaneTypeName: 'อ้อยสด',
        sugarcaneType: QueueSugarcaneType.FreshSugarcane,
        truckCount: 3,
      )),
    ],
  );
}
