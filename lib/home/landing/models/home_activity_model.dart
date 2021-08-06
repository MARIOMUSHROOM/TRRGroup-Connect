import '../../../base_class/models/ai_base_model.dart';

class HomeActivityModelItem extends AiBasicItem {
  String activityImage;
  String content;
  DateTime activityDate;

  HomeActivityModelItem({this.activityImage, this.content, this.activityDate});
}

class HomeActivityModelList extends AiBasicList {
  @override
  List<AiBaseItem> getObjList() => <HomeActivityModelItem>[];

  List<HomeActivityModelItem> get activityItems => super.items;

  addActivity(HomeActivityModelItem aActivityItem) {
    if (aActivityItem != null) activityItems.add(aActivityItem);
  }

  addActivities(List<HomeActivityModelItem> aActivityItems) {
    if (aActivityItems != null)
      aActivityItems.forEach((item) {
        addActivity(item);
      });
  }

  static HomeActivityModelList instance = HomeActivityModelList();
}

HomeActivityModelList dummyHomeActivityList() {
  final list = HomeActivityModelList.instance;
  list.items.clear();

  list.addActivities(
    [
      HomeActivityModelItem(
        activityImage: 'assets/images/landing/plant.png',
        content: 'มีการเพิ่มกิจกรรมอ้อยปลูกใหม่ \"ไถ่บุกเบิกครั้งที่ 1\" ริปเปอร์ระเบิดดินดาน ในแปลงที่ 1',
        activityDate: DateTime.now(),
      ),
      HomeActivityModelItem(
        activityImage: 'assets/images/landing/plant.png',
        content: 'มีการเพิ่มกิจกรรมประเภทอ้อยตอ \"ใส่ปุ๋ยคอมโพส\" ใส่ปุ๋ยครั้งที่ 1 ในแปลงที่ 4',
        activityDate: DateTime.now(),
      ),
      HomeActivityModelItem(
        activityImage: 'assets/images/landing/tractor.png',
        content: 'มีการเพิ่มกิจกรรมประเภทแปลงผสม \"ฉีดน้ำหมักปุ๋ยยูเรีย\" จำนวน 40 ไร่ ในแปลงที่ 15',
        activityDate: DateTime.now(),
      ),
      HomeActivityModelItem(
        activityImage: 'assets/images/landing/plant.png',
        content: 'มีการเพิ่มกิจกรรมอ้อยปลูกใหม่ \"ไถ่บุกเบิกครั้งที่ 1\" ริปเปอร์ระเบิดดินดาน ในแปลงที่ 1',
        activityDate: DateTime.now(),
      ),
      HomeActivityModelItem(
        activityImage: 'assets/images/landing/tractor.png',
        content: 'มีการเพิ่มกิจกรรมประเภทอ้อยตอ \"ใส่ปุ๋ยคอมโพส\" ใส่ปุ๋ยครั้งที่ 1 ในแปลงที่ 4',
        activityDate: DateTime.now(),
      ),
      HomeActivityModelItem(
        activityImage: 'assets/images/landing/plant.png',
        content: 'มีการเพิ่มกิจกรรมประเภทแปลงผสม \"ฉีดน้ำหมักปุ๋ยยูเรีย\" จำนวน 40 ไร่ ในแปลงที่ 15',
        activityDate: DateTime.now(),
      ),
    ],
  );

  return list;
}
