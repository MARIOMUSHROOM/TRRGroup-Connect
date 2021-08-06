import '../../../base_class/models/ai_base_model.dart';
import 'contractor_type_model.dart';
import '../../../global_utils.dart' as util;

const kfnContractorID = 'idContractor';
const kfnContractorName = 'name';
const kfnContractorFactoryID = 'idFactory';
const kfnContractorFactoryName = 'name';
const kfnContractorFactoryShortName = 'shortName';
const kfnContractorPhoneNumber = 'phoneNumber';
const kfnContractorDescription = 'description';
const kfnContractorImage = 'image';
const kfnContractorTypeObjKey = 'has_one_type_contractor';
const kfnContractorFactoryObjKey = 'has_one_factory';

class ContractorItem extends AiBasicItem {
  int contractorID;
  String fullName;

  @override
  List<String> getMapKeys() => [kfnContractorID, kfnContractorName];

  @override
  void internalLoadFromMapItem(Map<String, dynamic> aMap) {
    this.id = aMap[kfnContractorID];
    this.contractorID = this.id;
    this.fullName = aMap[kfnContractorName];
  }

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as ContractorItem;
    contractorID = s.contractorID;
    fullName = s.fullName;
  }
}

/* ----------------------------------------------------------------- */
class ContractorList extends AiBasicList {
  @override
  List<AiBaseItem> getObjList() => <ContractorItem>[];

  @override
  AiBaseItem getNewObjItem() => ContractorItem();

  List<ContractorItem> get contractorItems => super.items;

  static final ContractorList instance = ContractorList();
}

/* ----------------------------------------------------------------- */
class ContractorFactoryItem extends AiBasicItem {
  int factoryID;
  String factoryName;
  String factoryShortName;

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as ContractorFactoryItem;
    factoryID = s.factoryID;
    factoryName = s.factoryName;
    factoryShortName = s.factoryShortName;
  }

  @override
  List<String> getMapKeys() => [kfnContractorFactoryID, kfnContractorFactoryName, kfnContractorFactoryShortName];

  @override
  void internalLoadFromMapItem(Map<String, dynamic> aMap) {
    factoryID = aMap[kfnContractorFactoryID];
    factoryName = aMap[kfnContractorFactoryName];
    factoryShortName = aMap[kfnContractorFactoryShortName];
  }
}

class ContractorDetailItem extends AiBasicItem with AiHttpItemLoaderMixin {
  final ContractorFactoryItem factoryObj = ContractorFactoryItem();
  final ContractorTypeGridItem contractorTypeObj = ContractorTypeGridItem();

  String fullName = '';
  String phoneNumber = '';
  String information = '';
  String imageUrl = '';

  ContractorDetailItem({
    this.fullName,
    this.phoneNumber,
    this.information,
    this.imageUrl,
  });

  static final ContractorDetailItem instance = ContractorDetailItem();

  @override
  bool get internalIsEmpty => fullName == '';

  @override
  void internalLoadFromMapItem(Map<String, dynamic> aMap) {
    // to be implemented

    fullName = aMap[kfnContractorName];
    phoneNumber = aMap[kfnContractorPhoneNumber];
    information = aMap[kfnContractorDescription];
    // imageUrl = aMap[kfnContractorImage] == null ? '' : aMap[kfnContractorImage];
    imageUrl = util.safeDataAsString(aMap[kfnContractorImage]);

    contractorTypeObj.loadFromMapItem(aMap[kfnContractorTypeObjKey]);
    factoryObj.loadFromMapItem(aMap[kfnContractorFactoryObjKey]);
  }

  @override
  List<String> getMapKeys() => [
        kfnContractorName,
        kfnContractorPhoneNumber,
        kfnContractorDescription,
        kfnContractorImage,
        kfnContractorTypeObjKey,
        kfnContractorFactoryObjKey,
      ];

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as ContractorDetailItem;
    fullName = s.fullName;
    phoneNumber = s.phoneNumber;
    information = s.information;
    imageUrl = s.imageUrl;
    factoryObj.copyFrom(s.factoryObj);
    contractorTypeObj.copyFrom(s.contractorTypeObj);
  }
}

/* ---------------------------------------------------- */

// class ContractorDetailList extends AiBasicList {
//   @override
//   List<AiBaseItem> getObjList() {
//     return <ContractorDetailItem>[];
//   }

//   @override
//   AiBaseItem getNewObjItem() => ContractorDetailItem();

//   List<ContractorDetailItem> get contractors => super.items;

//   void addContractor(ContractorDetailItem aContractor) {
//     if (aContractor != null) contractors.add(aContractor);
//   }

//   static final ContractorDetailList instance = ContractorDetailList();
// }

/*  -----------------------------------------------------------------------------------------  */

// ContractorDetailList dummyContractorList() {
//   var list = ContractorDetailList.instance;
//   list.clear();

//   for (var i = 0; i <= 50; i++) {
//     var item = ContractorDetailItem()..copyFrom(getDummyContractorItem(i));
//     list.addContractor(item);
//   }

//   return list;
// }

// ContractorDetailItem getDummyContractorItem(int aCounter) {
//   int modRes = aCounter % 7;
//   switch (modRes) {
//     case 0:
//       return contItem1;
//     case 1:
//       return contItem2;
//     case 2:
//       return contItem3;
//     case 3:
//       return contItem4;
//     case 4:
//       return contItem5;
//     case 5:
//       return contItem6;
//     case 6:
//       return contItem7;
//     default:
//       return contItem1;
//   }
// }

// final ContractorDetailItem contItem1 = ContractorDetailItem(
//   firstName: 'สวัสดี',
//   lastName: 'มีชัย',
//   affiliateFactoryID: 1,
//   affiliateFactoryName: 'โรงงานสระบุรี',
//   contractorType: 0,
//   contractorTypeName: '',
//   information:
//       'รายละเอียด\nสวัสดีค่ะ  สามารถให้บริการ รับจ้างเกี่ยวกับการเตรียมดิน ลูกค้าที่สนใจสามารถติดต่อ  ได้ทางเบอร์โทรศัพท์ ติดต่อได้ทุกวัน เวลา 08:00 น. - 18:00 น.\n\n* ค่าบริการขึ้นอยู่กับการตกลงกับผู้ให้บริการ',
//   phoneNumber: '081 111 1111',
//   address: '',
//   imageUrl: '',
//   // imageUrl: 'https://i.pravatar.cc/12353',
// );

// final ContractorDetailItem contItem2 = ContractorDetailItem(
//   firstName: 'สุชาดา',
//   lastName: 'สุดใจ',
//   affiliateFactoryID: 1,
//   affiliateFactoryName: 'โรงงานสระบุรี',
//   contractorType: 1,
//   contractorTypeName: '',
//   information:
//       'รายละเอียด\nสวัสดีค่ะ  สามารถให้บริการ รับจ้างเกี่ยวกับการเตรียมดิน ลูกค้าที่สนใจสามารถติดต่อ  ได้ทางเบอร์โทรศัพท์ ติดต่อได้ทุกวัน เวลา 08:00 น. - 18:00 น.\n\n* ค่าบริการขึ้นอยู่กับการตกลงกับผู้ให้บริการ',
//   phoneNumber: '082 222 2222',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=20',
// );

// final ContractorDetailItem contItem3 = ContractorDetailItem(
//   firstName: 'วันชัย',
//   lastName: 'เจริญพร',
//   affiliateFactoryID: 2,
//   affiliateFactoryName: 'โรงงานกาญจนบุรี',
//   contractorType: 2,
//   contractorTypeName: '',
//   information:
//       'รายละเอียด\nสวัสดีค่ะ  สามารถให้บริการ รับจ้างเกี่ยวกับการเตรียมดิน ลูกค้าที่สนใจสามารถติดต่อ  ได้ทางเบอร์โทรศัพท์ ติดต่อได้ทุกวัน เวลา 08:00 น. - 18:00 น.\n\n* ค่าบริการขึ้นอยู่กับการตกลงกับผู้ให้บริการ',
//   phoneNumber: '083 333 3333',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=14',
// );

// final ContractorDetailItem contItem4 = ContractorDetailItem(
//   firstName: 'มีโชค',
//   lastName: 'มั่งมี',
//   affiliateFactoryID: 3,
//   affiliateFactoryName: 'โรงงานลพบุรี',
//   contractorType: 3,
//   contractorTypeName: '',
//   information:
//       'รายละเอียด\nสวัสดีค่ะ  สามารถให้บริการ รับจ้างเกี่ยวกับการเตรียมดิน ลูกค้าที่สนใจสามารถติดต่อ  ได้ทางเบอร์โทรศัพท์ ติดต่อได้ทุกวัน เวลา 08:00 น. - 18:00 น.\n\n* ค่าบริการขึ้นอยู่กับการตกลงกับผู้ให้บริการ',
//   phoneNumber: '084 444 4444',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/300?img=11',
// );

// final ContractorDetailItem contItem5 = ContractorDetailItem(
//   firstName: 'ยุพิน',
//   lastName: 'ยินดี',
//   affiliateFactoryID: 4,
//   affiliateFactoryName: 'โรงงานเพชรบูรณ์',
//   contractorType: 4,
//   contractorTypeName: '',
//   information:
//       'รายละเอียด\nสวัสดีค่ะ  สามารถให้บริการ รับจ้างเกี่ยวกับการเตรียมดิน ลูกค้าที่สนใจสามารถติดต่อ  ได้ทางเบอร์โทรศัพท์ ติดต่อได้ทุกวัน เวลา 08:00 น. - 18:00 น.\n\n* ค่าบริการขึ้นอยู่กับการตกลงกับผู้ให้บริการ',
//   phoneNumber: '085 555 5555',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=26',
// );

// final ContractorDetailItem contItem6 = ContractorDetailItem(
//   firstName: 'สันชัย',
//   lastName: 'ใจดี',
//   affiliateFactoryID: 4,
//   affiliateFactoryName: 'โรงงานเพชรบูรณ์',
//   contractorType: 4,
//   contractorTypeName: '',
//   information:
//       'รายละเอียด\nสวัสดีค่ะ  สามารถให้บริการ รับจ้างเกี่ยวกับการเตรียมดิน ลูกค้าที่สนใจสามารถติดต่อ  ได้ทางเบอร์โทรศัพท์ ติดต่อได้ทุกวัน เวลา 08:00 น. - 18:00 น.\n\n* ค่าบริการขึ้นอยู่กับการตกลงกับผู้ให้บริการ',
//   phoneNumber: '086 666 6666',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=54',
// );

// final ContractorDetailItem contItem7 = ContractorDetailItem(
//   firstName: 'สุชัย',
//   lastName: 'สำราญใจ',
//   affiliateFactoryID: 2,
//   affiliateFactoryName: 'โรงงานกาญจนบุรี',
//   contractorType: 2,
//   contractorTypeName: '',
//   information:
//       'รายละเอียด\nสวัสดีค่ะ  สามารถให้บริการ รับจ้างเกี่ยวกับการเตรียมดิน ลูกค้าที่สนใจสามารถติดต่อ  ได้ทางเบอร์โทรศัพท์ ติดต่อได้ทุกวัน เวลา 08:00 น. - 18:00 น.\n\n* ค่าบริการขึ้นอยู่กับการตกลงกับผู้ให้บริการ',
//   phoneNumber: '087 777 7777',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=2',
// );

// /*
// โรงงานสระบุรี
// โรงงานกาญจนบุรี
// โรงงานลพบุรี
// โรงงานเพชรบูรณ์

// รับจ้างเตรียมดิน
// รับจ้างปลูกอ้อย
// รับจ้างเหมาปลูก
// รับจ้างให้น้ำ
// รับจ้างดูแลรักษา
// รับจ้างเก็บเกี่ยว
//  */
