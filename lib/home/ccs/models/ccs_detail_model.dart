import '../../../base_class/models/ai_base_model.dart';

class CcsDetailItem extends AiBasicItem {
  DateTime ccsDate;
  String truckRegistration;
  String sugarcaneBill;
  String sugarcaneType;
  String sampleNumber;
  double netWeight;
  double ccsValue;

  CcsDetailItem({
    this.ccsDate,
    this.truckRegistration,
    this.sugarcaneBill,
    this.sugarcaneType,
    this.sampleNumber,
    this.netWeight,
    this.ccsValue,
  });

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    CcsDetailItem s = aSource as CcsDetailItem;
    ccsDate = s.ccsDate;
    truckRegistration = s.truckRegistration;
    sugarcaneBill = s.sugarcaneBill;
    sugarcaneType = s.sugarcaneType;
    sampleNumber = s.sampleNumber;
    netWeight = s.netWeight;
    ccsValue = s.ccsValue;
  }
}

class CcsDetailList extends AiBasicList {
  @override
  AiBaseItem getNewObjItem() {
    return CcsDetailItem();
  }

  @override
  List<AiBaseItem> getObjList() {
    return <CcsDetailItem>[];
  }

  List<CcsDetailItem> get ccsItems => super.items;

  void addNewCcsItem(CcsDetailItem aCcsDataItem) {
    ccsItems.add(aCcsDataItem);
  }

  static CcsDetailList instance = CcsDetailList();
}

CcsDetailList dummyCcsDetailList() {
  var result = CcsDetailList.instance;
  result.clear();

  for (var i = 1; i <= 20; i++) {
    result.addNewCcsItem(_getDummyCcsDataItem(i));
  }
  return result;
}

// Test Data
CcsDetailItem item1 = CcsDetailItem(
  ccsDate: DateTime.now().subtract(Duration(days: 60)),
  truckRegistration: 'สต - 84 - 8033',
  sugarcaneBill: '16737',
  sugarcaneType: 'อ้อยธรรมดา',
  sampleNumber: '12806',
  netWeight: 40.98,
  ccsValue: 12.9,
);

CcsDetailItem item2 = CcsDetailItem(
  ccsDate: DateTime.now().subtract(Duration(days: 57)),
  truckRegistration: 'สต - 34 - 6446',
  sugarcaneBill: '15299',
  sugarcaneType: 'อ้อยธรรมดา',
  sampleNumber: '18689',
  netWeight: 12.98,
  ccsValue: 39.1,
);

CcsDetailItem item3 = CcsDetailItem(
  ccsDate: DateTime.now().subtract(Duration(days: 43)),
  truckRegistration: 'สต - 09 - 1113',
  sugarcaneBill: '90766',
  sugarcaneType: 'อ้อยธรรมดา',
  sampleNumber: '36273',
  netWeight: 90.22,
  ccsValue: 50.21,
);

CcsDetailItem item4 = CcsDetailItem(
  ccsDate: DateTime.now().subtract(Duration(days: 36)),
  truckRegistration: 'สต - 88 - 0896',
  sugarcaneBill: '38576',
  sugarcaneType: 'อ้อยธรรมดา',
  sampleNumber: '90887',
  netWeight: 65.32,
  ccsValue: 71.78,
);

CcsDetailItem item5 = CcsDetailItem(
  ccsDate: DateTime.now().subtract(Duration(days: 89)),
  truckRegistration: 'สต - 15 - 1215',
  sugarcaneBill: '67890',
  sugarcaneType: 'อ้อยธรรมดา',
  sampleNumber: '94859',
  netWeight: 58.21,
  ccsValue: 49.88,
);

// Test data
CcsDetailItem _getDummyCcsDataItem(int aCount) {
  var modResult = aCount % 5;
  switch (modResult) {
    case 0:
      return item5;
    case 1:
      return item1;
    case 2:
      return item2;
    case 3:
      return item3;
    case 4:
      return item4;
    default:
      return item1;
  }
}
