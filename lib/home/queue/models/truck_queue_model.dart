// import '../queue_const.dart' as cons;

class TruckQueueModel {
  String truckRegistration;
  double netWeight;
  double ccsValue;
  List<TruckQueueDetailModel> queueDetailList;
  TruckQueueModel({this.truckRegistration, this.netWeight, this.ccsValue, this.queueDetailList});
}

/* --------------------------------------------------------------------------------------------- */
class TruckQueueDetailModel {
  DateTime queueDateTime;
  TruckQueueDetailModel({this.queueDateTime});
}

/* --------------------------------------------------------------------------------------------- */
TruckQueueModel dummyTQ1 = TruckQueueModel(
  truckRegistration: 'สย-9898-6669',
  netWeight: 22.90,
  ccsValue: 11.13,
  queueDetailList: dummyTruckDetailList,
);

TruckQueueModel dummyTQ2 = TruckQueueModel(
  truckRegistration: 'คร-5698-1235',
  netWeight: 24.90,
  ccsValue: 13.19,
  queueDetailList: dummyTruckDetailList,
);

TruckQueueModel dummyTQ3 = TruckQueueModel(
  truckRegistration: 'อป-6698-4789',
  netWeight: 18.20,
  ccsValue: 10.17,
  queueDetailList: dummyTruckDetailList,
);

TruckQueueModel dummyTQ4 = TruckQueueModel(
  truckRegistration: 'มย-6586-4823',
  netWeight: 24.10,
  ccsValue: 12.16,
  queueDetailList: dummyTruckDetailList,
);

TruckQueueModel dummyTQ5 = TruckQueueModel(
  truckRegistration: 'อป-6698-4789',
  netWeight: 18.20,
  ccsValue: 10.17,
  queueDetailList: dummyTruckDetailList,
);

TruckQueueModel dummyTQ6 = TruckQueueModel(
  truckRegistration: 'มย-6586-4823',
  netWeight: 24.10,
  ccsValue: 12.16,
  queueDetailList: dummyTruckDetailList,
);

final List<TruckQueueDetailModel> dummyTruckDetailList = [
  TruckQueueDetailModel(queueDateTime: DateTime.now()),
  TruckQueueDetailModel(queueDateTime: DateTime.now().subtract(Duration(days: 1, hours: 12))),
  TruckQueueDetailModel(queueDateTime: DateTime.now().subtract(Duration(days: 2, hours: 20))),
  TruckQueueDetailModel(queueDateTime: DateTime.now().subtract(Duration(days: 3, hours: 14))),
];

final List<TruckQueueModel> dummyTruckQueueList = [dummyTQ1, dummyTQ2, dummyTQ3, dummyTQ4, dummyTQ5, dummyTQ6];
