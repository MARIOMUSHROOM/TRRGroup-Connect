import '../../base_class/models/ai_base_model.dart';

class ProfileProductYearAgricultureItem extends AiBasicItem {
  @override
  internalLoadFromMapItem(Map<String, dynamic> aMap) {
    /* load data from Json here */
  }

  final String cultureYearLabel;

  @override
  List<String> getMapKeys() => [/* setup list of key named for Json API here */];

  ProfileProductYearAgricultureItem({int id, this.cultureYearLabel}) : super(id: id);
}

class ProfileProductYearAgricultureList extends AiBasicList {
  @override
  List<AiBaseItem> getObjList() => <ProfileProductYearAgricultureItem>[];

  List<ProfileProductYearAgricultureItem> get cultureYears => super.items;

  static ProfileProductYearAgricultureList dummyYear = ProfileProductYearAgricultureList()
    ..cultureYears.addAll(
      [
        ProfileProductYearAgricultureItem(id: 1, cultureYearLabel: 'ปี 65/66'),
        ProfileProductYearAgricultureItem(id: 2, cultureYearLabel: 'ปี 64/65'),
        ProfileProductYearAgricultureItem(id: 3, cultureYearLabel: 'ปี 63/64'),
        ProfileProductYearAgricultureItem(id: 4, cultureYearLabel: 'ปี 62/63'),
        ProfileProductYearAgricultureItem(id: 5, cultureYearLabel: 'ปี 61/62'),
      ],
    );
}
