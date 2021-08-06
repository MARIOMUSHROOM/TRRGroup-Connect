import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// ---------------------------------------------------------------------------------
class AiBaseItem {
  int id = 0;
  int tag = 0;

  AiBaseItem({this.id});

  @protected
  List<String> getMapKeys() => [];

  @protected
  void internalLoadFromMapItem(Map<String, dynamic> aMap) {/* load from http map */}

  @protected
  Map<String, dynamic> internalAsMap() => null;
  Map<String, dynamic> asMap() => internalAsMap();

  @protected
  void internalCopyFrom(dynamic aSource) {
    AiBaseItem source = aSource as AiBaseItem;
    this.id = source.id;
    this.tag = source.tag;
  }

  bool copyFrom(dynamic aSource) {
    if (aSource != null && aSource.runtimeType == this.runtimeType) {
      internalCopyFrom(aSource);
      return true;
    } else
      return false;
  }

  /* check if object empty by validate to some property of object */
  @protected
  bool get internalIsEmpty => id == 0;

  /* external call */
  bool get isEmpty => internalIsEmpty;

  /* Print debug */
  void debug(dynamic aObject) {
    if (aObject != null) print('Debugging from AI Class name : ${this.runtimeType} - $aObject');
  }

  @protected
  void internalClearData() {
    id = 0;
    tag = 0;
    // to be implemented
  }

  void clearData() => internalClearData();
}

/// ---------------------------------------------------------------------------------
class AiBaseList extends AiBaseItem {
  List<AiBaseItem> _objList;

  // @protected
  // Type getItemType() => getNewObjItem().runtimeType;

  @protected
  AiBaseItem getNewObjItem() => AiBaseItem(); // return object item of list

  @protected
  List<AiBaseItem> getObjList() => <AiBaseItem>[];

  List<AiBaseItem> get items {
    if (_objList == null) _objList = getObjList();
    return _objList;
  }

  set items(List<AiBaseItem> aList) => _objList = aList;

  @protected
  internalLoadFromMapList(List<dynamic> aMapList) {}

  loadFromMapList(List<dynamic> aMapList, [bool aIsClearBeforeLoad = true]) {
    if (aIsClearBeforeLoad) clear(); // check if clear list before loading
    if (aMapList != null && aMapList.isNotEmpty) internalLoadFromMapList(aMapList);
  }

  bool cloneFrom(AiBaseList aSourceList) {
    if (aSourceList != null && aSourceList.isNotEmpty)
      internalCloneFrom(aSourceList);
    else
      return false;
  }

  @protected
  bool internalCloneFrom(AiBaseList aSourceList) {
    clear();
    aSourceList.items.forEach((sourceItem) => addItem(getNewObjItem()..copyFrom(sourceItem)));
    return count > 0;
  }

  @override
  void internalClearData() => clear();

  AiBaseItem getItem(int aIndex) {
    var result;
    if (isNotEmpty && aIndex < this.count) result = items[aIndex];
    return result;
  }

  // Transfer methods and properties
  void clear() => items.clear();
  int get length => items.length;
  int get count => this.length;
  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  void addItem(AiBaseItem item) => items.add(item);
  void reversedItems() => items.reversed;
  Iterable<AiBaseItem> get reversed => items.reversed;
}

/// ---------------------------------------------------------------------------------
mixin AiHttpItemLoaderMixin on AiBaseItem {
  bool canLoadFromMap(Map<String, dynamic> aMap, List<String> aKeys) {
    var valid = (aMap != null) && (aKeys.isNotEmpty);
    if (valid) {
      for (String key in aKeys) {
        valid = aMap.containsKey(key);
        if (!valid) break;
      }
    }
    return valid;
  }

  loadFromMapItem(Map<String, dynamic> aMap) {
    if (canLoadFromMap(aMap, getMapKeys())) internalLoadFromMapItem(aMap);
  }

  /* response has to be single map object */
  loadFromHttpData(http.Response aResponseObj) {
    if (aResponseObj != null) {
      final mapObj = json.decode(aResponseObj.body) as Map<String, dynamic>;
      loadFromMapItem(mapObj);
    }
  }
}

/// ---------------------------------------------------------------------------------
mixin AiHttpListLoaderMixin on AiBaseList {
  // implement load from http response list
  loadFromHttpData(http.Response aResponseList, [bool aIsClearBeforeLoad = true]) {
    if (aResponseList != null) {
      final mapList = json.decode(aResponseList.body) as List<dynamic>;
      loadFromMapList(mapList, aIsClearBeforeLoad);
    }
  }
}

// / ---------------------------------------------------------------------------------
class AiBasicItem extends AiBaseItem with AiHttpItemLoaderMixin {
  AiBasicItem({int id}) : super(id: id);
}

/// ---------------------------------------------------------------------------------
/// subclass should be inherit from AiBasicList
class AiBasicList extends AiBaseList with AiHttpListLoaderMixin {
  @override
  AiBaseItem getNewObjItem() => AiBasicItem();

  @override
  List<AiBaseItem> getObjList() => <AiBasicItem>[];

  @override
  internalLoadFromMapList(List<dynamic> aMapList) {
    aMapList.forEach(
      (item) {
        var mapItem = item as Map<String, dynamic>;
        var newItem = this.getNewObjItem() as AiBasicItem;
        newItem.loadFromMapItem(mapItem);
        items.add(newItem);
      },
    );
  }
}

// / ---------------------------------------------------------------------------------
