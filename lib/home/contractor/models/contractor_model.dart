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
//   firstName: '??????????????????',
//   lastName: '???????????????',
//   affiliateFactoryID: 1,
//   affiliateFactoryName: '???????????????????????????????????????',
//   contractorType: 0,
//   contractorTypeName: '',
//   information:
//       '??????????????????????????????\n???????????????????????????  ????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????  ????????????????????????????????????????????????????????? ????????????????????????????????????????????? ???????????? 08:00 ???. - 18:00 ???.\n\n* ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
//   phoneNumber: '081 111 1111',
//   address: '',
//   imageUrl: '',
//   // imageUrl: 'https://i.pravatar.cc/12353',
// );

// final ContractorDetailItem contItem2 = ContractorDetailItem(
//   firstName: '??????????????????',
//   lastName: '???????????????',
//   affiliateFactoryID: 1,
//   affiliateFactoryName: '???????????????????????????????????????',
//   contractorType: 1,
//   contractorTypeName: '',
//   information:
//       '??????????????????????????????\n???????????????????????????  ????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????  ????????????????????????????????????????????????????????? ????????????????????????????????????????????? ???????????? 08:00 ???. - 18:00 ???.\n\n* ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
//   phoneNumber: '082 222 2222',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=20',
// );

// final ContractorDetailItem contItem3 = ContractorDetailItem(
//   firstName: '??????????????????',
//   lastName: '?????????????????????',
//   affiliateFactoryID: 2,
//   affiliateFactoryName: '?????????????????????????????????????????????',
//   contractorType: 2,
//   contractorTypeName: '',
//   information:
//       '??????????????????????????????\n???????????????????????????  ????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????  ????????????????????????????????????????????????????????? ????????????????????????????????????????????? ???????????? 08:00 ???. - 18:00 ???.\n\n* ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
//   phoneNumber: '083 333 3333',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=14',
// );

// final ContractorDetailItem contItem4 = ContractorDetailItem(
//   firstName: '???????????????',
//   lastName: '??????????????????',
//   affiliateFactoryID: 3,
//   affiliateFactoryName: '????????????????????????????????????',
//   contractorType: 3,
//   contractorTypeName: '',
//   information:
//       '??????????????????????????????\n???????????????????????????  ????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????  ????????????????????????????????????????????????????????? ????????????????????????????????????????????? ???????????? 08:00 ???. - 18:00 ???.\n\n* ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
//   phoneNumber: '084 444 4444',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/300?img=11',
// );

// final ContractorDetailItem contItem5 = ContractorDetailItem(
//   firstName: '???????????????',
//   lastName: '???????????????',
//   affiliateFactoryID: 4,
//   affiliateFactoryName: '?????????????????????????????????????????????',
//   contractorType: 4,
//   contractorTypeName: '',
//   information:
//       '??????????????????????????????\n???????????????????????????  ????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????  ????????????????????????????????????????????????????????? ????????????????????????????????????????????? ???????????? 08:00 ???. - 18:00 ???.\n\n* ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
//   phoneNumber: '085 555 5555',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=26',
// );

// final ContractorDetailItem contItem6 = ContractorDetailItem(
//   firstName: '??????????????????',
//   lastName: '????????????',
//   affiliateFactoryID: 4,
//   affiliateFactoryName: '?????????????????????????????????????????????',
//   contractorType: 4,
//   contractorTypeName: '',
//   information:
//       '??????????????????????????????\n???????????????????????????  ????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????  ????????????????????????????????????????????????????????? ????????????????????????????????????????????? ???????????? 08:00 ???. - 18:00 ???.\n\n* ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
//   phoneNumber: '086 666 6666',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=54',
// );

// final ContractorDetailItem contItem7 = ContractorDetailItem(
//   firstName: '???????????????',
//   lastName: '?????????????????????',
//   affiliateFactoryID: 2,
//   affiliateFactoryName: '?????????????????????????????????????????????',
//   contractorType: 2,
//   contractorTypeName: '',
//   information:
//       '??????????????????????????????\n???????????????????????????  ????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????????  ????????????????????????????????????????????????????????? ????????????????????????????????????????????? ???????????? 08:00 ???. - 18:00 ???.\n\n* ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
//   phoneNumber: '087 777 7777',
//   address: '',
//   imageUrl: 'https://i.pravatar.cc/150?img=2',
// );

// /*
// ???????????????????????????????????????
// ?????????????????????????????????????????????
// ????????????????????????????????????
// ?????????????????????????????????????????????

// ????????????????????????????????????????????????
// ?????????????????????????????????????????????
// ?????????????????????????????????????????????
// ???????????????????????????????????????
// ????????????????????????????????????????????????
// ???????????????????????????????????????????????????
//  */
