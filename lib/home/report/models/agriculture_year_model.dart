import '../../../base_class/models/ai_base_model.dart';

class AgricultureYearItem extends AiBasicItem {
  int currentYear;
  String agricultureYearCaption;
  AgricultureYearItem({int id, this.currentYear, this.agricultureYearCaption}) : super(id: id);
  bool isSameYear(int aThaiYear) => this.currentYear == aThaiYear;
}

class AgricultureYearList extends AiBasicList {
  @override
  AiBaseItem getNewObjItem() => AgricultureYearItem();

  @override
  List<AiBaseItem> getObjList() => <AgricultureYearItem>[];

  AgricultureYearItem itemByYear(int aThaiYear) {
    for (var i = 0; i < items.length; i++) {
      var it = items[i] as AgricultureYearItem;
      if (it.isSameYear(aThaiYear)) return it;
    }
    return null;
  }

  static AgricultureYearList _instance;

  static getYearList() {
    if (_instance == null)
      _instance = AgricultureYearList();
    else
      return _instance;

    int itemYear = DateTime.now().year + 543; // Turning to Thai year

    for (var i = 1; i <= 100; i++) {
      _instance.items.add(
        AgricultureYearItem(
          id: i,
          currentYear: itemYear,
          agricultureYearCaption: '$itemYear/${itemYear + 1}',
        ),
      );
      itemYear++;
    }
    return _instance;
  }
}
