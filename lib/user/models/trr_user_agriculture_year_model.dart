import '../../base_class/models/ai_base_model.dart';
import './trr_group_year_json_model.dart';

class TrrUserAgricultureYearItem extends AiBasicItem {
  String yearText;
  int yearValue;

  TrrUserAgricultureYearItem({
    this.yearText = '',
    this.yearValue = 0,
  });

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    var s = aSource as TrrUserAgricultureYearItem;
    yearText = s.yearText;
    yearValue = s.yearValue;
    this.id = yearValue;
  }

  @override
  void internalClearData() {
    super.internalClearData();
    yearText = '';
    yearValue = 0;
    id = 0;
  }

  @override
  bool get internalIsEmpty => yearValue == 0;

  void copyFromGroupYearModelItem(GroupYearJsonModelItem aGroupYearItem) {
    if (aGroupYearItem != null) {
      var s = aGroupYearItem;
      yearValue = s.value;
      yearText = s.text;
      id = yearValue;
    }
  }

  // bool isSameYearValue(int aYearValue) {if (aYearValue != null) return aYearValue == this.yearValue;}
  bool isSameYear(int aYearValue) => aYearValue ?? aYearValue == this.yearValue;
  TrrUserAgricultureYearItem itemByYearValue(int aYearValue) => isSameYear(aYearValue) ? this : null;
}

// --------------------------------------------------------------------------------------------------------------
class TrrUserAgricultureYearList extends AiBasicList {
  @override
  AiBaseItem getNewObjItem() => TrrUserAgricultureYearItem();

  @override
  List<AiBaseItem> getObjList() => <TrrUserAgricultureYearItem>[];

  TrrUserAgricultureYearItem getYearItem(int aIndex) {
    var result = this.getItem(aIndex);
    // result ?? => if item exist and if not null return result as classtype
    return result ?? result as TrrUserAgricultureYearItem;
  }

  void copyFromGroupYearModelObj(TrrGroupYearJsonModel aGroupYearObj) {
    clear();
    if (aGroupYearObj != null && aGroupYearObj.isNotEmpty)
      aGroupYearObj.data.forEach(
        (sourceItem) => this.addItem(TrrUserAgricultureYearItem()..copyFromGroupYearModelItem(sourceItem)),
      );
  }

  TrrUserAgricultureYearItem itemByYearValue(int aYearValue) {
    TrrUserAgricultureYearItem result;

    if (isEmpty) return result;

    for (var i = 0; i < count; i++) {
      var currItem = getYearItem(i);
      if (currItem.itemByYearValue(aYearValue) != null) {
        result = currItem;
        break;
      }
    }
    return result;
  }

  // function return new list object with reverse items order;
  TrrUserAgricultureYearList getDescendingYearList() {
    // create new list then clone from current object then reverse items
    return new TrrUserAgricultureYearList()
      ..cloneFrom(this)
      ..reversed;

    // TrrUserAgricultureYearList resultList = new TrrUserAgricultureYearList();
    // return resultList
    //   ..cloneFrom(this)
    //   ..reversed;
  }
}
