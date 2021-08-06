import 'dart:core';

import '../../../base_class/models/ai_base_model.dart';

class ReportActivityDetailItem extends AiBasicItem with AiHttpItemLoaderMixin {
  @override
  List<String> getMapKeys() => ['activity_detail_name'];

  String detailDescription;
  ReportActivityDetailItem({this.detailDescription});
}

class ReportActivityDetailList extends AiBasicList with AiHttpListLoaderMixin {
  @override
  List<AiBaseItem> getObjList() => <ReportActivityDetailItem>[];

  @override
  AiBaseItem getNewObjItem() => ReportActivityDetailItem();

  List<ReportActivityDetailItem> get detailItems => super.items;
}

class ReportActivityItem extends AiBasicItem with AiHttpItemLoaderMixin {
  String label;
  ReportActivityDetailList detailList;

  @override
  List<String> getMapKeys() => ['activity_name'];

  @override
  internalLoadFromMapItem(Map<String, dynamic> aMap) {
    label = aMap['activity_name'];
    final list = aMap['activity_detail_list'] as List<dynamic>;
    detailList.loadFromMapList(list);

    // {
    //   'activity_name': 'ให้น้ำ',
    //   'activity_detail_list':
    //   [
    //     {'activity_detail_name': 'ริปเปอร์ระเบิดดินดาน'}.
    //     {'activity_detail_name': 'ค่าจ้างรถไถ 1,000 บาท'}.
    //     {'activity_detail_name': 'ค่าจ้างแรงงาน 1,000 บาท'}.
    //     {'activity_detail_name': 'ปริมาณใช้เชื้อเพลิง 10 ลิตร'}.
    //   ]
    // }
  }

  ReportActivityItem({this.label, this.detailList});
}

class ReportActivityList extends AiBasicList with AiHttpListLoaderMixin {
  @override
  List<AiBaseItem> getObjList() => <ReportActivityItem>[];

  @override
  AiBaseItem getNewObjItem() => ReportActivityItem();

  List<ReportActivityItem> get activityItems => super.items;
}

class ReportActivityDateItem extends AiBasicItem with AiHttpItemLoaderMixin {
  DateTime activityDateTime;
  ReportActivityList activityList;
  ReportActivityDateItem({this.activityDateTime, this.activityList});
}

class ReportActivityDateList extends AiBasicList with AiHttpListLoaderMixin {
  @override
  List<AiBaseItem> getObjList() => <ReportActivityDateItem>[];

  @override
  AiBaseItem getNewObjItem() => ReportActivityDateItem();

  List<ReportActivityDateItem> get dateItems => super.items;

  static ReportActivityDateList instance = ReportActivityDateList();
}

class ReportPlotItem extends AiBasicItem with AiHttpItemLoaderMixin {
  String plotName;
  String plotTypeName;
  double raiCount;
  double sugarcaneVolume;
  ReportActivityDateList activityDateList;
  ReportPlotItem({this.plotName, this.plotTypeName, this.raiCount, this.sugarcaneVolume, this.activityDateList});
}

class ReportPlotList extends AiBasicList {
  @override
  List<AiBaseItem> getObjList() => <ReportPlotItem>[];

  @override
  AiBaseItem getNewObjItem() => ReportPlotItem();

  List<ReportPlotItem> get plotItems => super.items;

  static ReportPlotList instance = ReportPlotList();

  double productSummary;
}
