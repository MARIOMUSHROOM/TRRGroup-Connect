import 'package:ai_flutter/home/contractor/models/contractor_model.dart';
import 'package:flutter/foundation.dart';

import '../../../base_class/models/ai_base_model.dart';

const kfnContractorTypeID = 'idTypeContractor';
const kfnContractorTypeName = 'name';
const kfnContractorTypeIconPath = 'path';
const kDomainName = 'https://www.trrgroup.advancedis.co.th';

// enum ContractorTypeIndex {
//   SoilPreparation,
//   GrowSugarcane,
//   OverallPlantation,
//   WaterSupply,
//   OutsourcingCare,
//   Harvesting,
// }

class ContractorTypeGridItem extends AiBasicItem {
  // int get contractorID => this.id;

  // String imageIcon;
  int contractorTypeID;
  String label;
  // ContractorTypeIndex contractorType;

  @protected
  String iconPath;

  String get iconUrl => '$kDomainName$iconPath';

  // String get imageIcon {
  //   switch (contractorType) {
  //     case ContractorTypeIndex.SoilPreparation:
  //       return 'assets/images/contractor/soil_preparation.png';
  //     case ContractorTypeIndex.GrowSugarcane:
  //       return 'assets/images/contractor/grow_sugarcane.png';
  //     case ContractorTypeIndex.OverallPlantation:
  //       return 'assets/images/contractor/overall_plantation.png';
  //     case ContractorTypeIndex.WaterSupply:
  //       return 'assets/images/contractor/water_supply.png';
  //     case ContractorTypeIndex.OutsourcingCare:
  //       return 'assets/images/contractor/outsourcing_care.png';
  //     case ContractorTypeIndex.Harvesting:
  //       return 'assets/images/contractor/harvesting.png';
  //     default:
  //       return 'assets/images/contractor/soil_preparation.png';
  //   }
  // }

  ContractorTypeGridItem({
    // this.imageIcon,
    this.contractorTypeID,
    this.label,
    // this.contractorType,
    this.iconPath,
  });

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as ContractorTypeGridItem;
    // imageIcon = s.imageIcon;
    contractorTypeID = s.contractorTypeID;
    label = s.label;
    iconPath = s.iconPath;
    // contractorType = s.contractorType;
  }

  @override
  void internalLoadFromMapItem(Map<String, dynamic> aMap) {
    super.internalLoadFromMapItem(aMap);
    id = aMap[kfnContractorTypeID];
    contractorTypeID = id;
    label = aMap[kfnContractorTypeName];
    iconPath = aMap[kfnContractorTypeIconPath];

    // contractorType = ContractorTypeIndex.values[(aMap[kfnContractorType] as int) - 1];
  }

  @override
  List<String> getMapKeys() => [kfnContractorTypeID, kfnContractorTypeName];
}

class ContractorTypeGridList extends AiBasicList with AiHttpListLoaderMixin {
  @override
  AiBaseItem getNewObjItem() => ContractorTypeGridItem();

  @override
  List<AiBaseItem> getObjList() => <ContractorTypeGridItem>[];

  addContractorType(ContractorTypeGridItem aTypeItem) {
    if (aTypeItem != null) typeItems.add(aTypeItem);
  }

  addAllContractorTypes(List<ContractorTypeGridItem> aTypeItems) {
    if (aTypeItems != null) typeItems.addAll(aTypeItems);
  }

  ContractorTypeGridItem findByContractorType(int aContractorTypeID) {
    for (var item in typeItems) {
      if (item.contractorTypeID == aContractorTypeID) return item;
      // break;
    }
    return null;
  }

  List<ContractorTypeGridItem> get typeItems => super.items;

  static final ContractorTypeGridList instance = ContractorTypeGridList();
}

// ..addAllContractorTypes(
//   [
//     ContractorTypeGridItem(
//       // imageIcon: 'assets/images/contractor/soil_preparation.png',
//       label: 'รับจ้างเตรียมดิน',
//       contractorType: ContractorTypeIndex.SoilPreparation,
//     ),
//     ContractorTypeGridItem(
//       // imageIcon: 'assets/images/contractor/grow_sugarcane.png',
//       label: 'รับจ้างปลูกอ้อย',
//       contractorType: ContractorTypeIndex.GrowSugarcane,
//     ),
//     ContractorTypeGridItem(
//       // imageIcon: 'assets/images/contractor/overall_plantation.png',
//       label: 'รับจ้างเหมาปลูก',
//       contractorType: ContractorTypeIndex.OverallPlantation,
//     ),
//     ContractorTypeGridItem(
//       // imageIcon: 'assets/images/contractor/water_supply.png',
//       label: 'รับจ้างให้น้ำ',
//       contractorType: ContractorTypeIndex.WaterSupply,
//     ),
//     ContractorTypeGridItem(
//       // imageIcon: 'assets/images/contractor/outsourcing_care.png',
//       label: 'รับจ้างดูแลรักษา',
//       contractorType: ContractorTypeIndex.OutsourcingCare,
//     ),
//     ContractorTypeGridItem(
//       // imageIcon: 'assets/images/contractor/harvesting.png',
//       label: 'รับจ้างเก็บเกี่ยว',
//       contractorType: ContractorTypeIndex.Harvesting,
//     ),
//   ],
// );
