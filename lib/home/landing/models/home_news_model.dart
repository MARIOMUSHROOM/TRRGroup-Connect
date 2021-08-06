import '../../../base_class/models/ai_base_model.dart';

class HomeNewsModelItem extends AiBasicItem {
  String newsImage;
  String title;
  String subTitle;

  HomeNewsModelItem({this.newsImage, this.title, this.subTitle});
}

class HomeNewsModelList extends AiBasicList {
  @override
  List<AiBaseItem> getObjList() => <HomeNewsModelItem>[];

  List<HomeNewsModelItem> get newsItems => super.items;

  addNewsItem(HomeNewsModelItem aNewItem) {
    if (aNewItem != null) newsItems.add(aNewItem);
  }

  addNewsItems(List<HomeNewsModelItem> aNewsList) {
    if (aNewsList != null && aNewsList.isNotEmpty)
      aNewsList.forEach((item) {
        addNewsItem(item);
      });
  }

  static HomeNewsModelList instance = HomeNewsModelList();
}

HomeNewsModelList dummyNewsList() {
  var list = HomeNewsModelList.instance;
  list.newsItems.clear();

  list.addNewsItems([
    HomeNewsModelItem(
      newsImage: 'assets/images/landing/sample/plot7.jpg',
      title: 'สอนลงพื้นที่ราชบุรีตรวจสอบผลการดำเนินงานโรงงานน้ำตาลและเยี่ยมชมการบริหารจัดการไร่อ้อย',
      subTitle: '11 ชั่วโมงที่ผ่านมา',
    ),
    HomeNewsModelItem(
      newsImage: 'assets/images/landing/sample/plot11.jpg',
      title: 'เกษตรกรชาวไร่อ้อย ตรวจสอบสิทธิ์เงินช่วยเหลือ',
      subTitle: '15 ชั่วโมงที่ผ่านมา',
    ),
    HomeNewsModelItem(
      newsImage: 'assets/images/landing/sample/plot9.jpg',
      title: 'เกษตรกรชาวไร่อ้อย เตรียมจดทะเบียนรับสิทธิประโยชน์',
      subTitle: '19 ชั่วโมงที่ผ่านมา',
    ),
    HomeNewsModelItem(
      newsImage: 'assets/images/landing/sample/plot10.jpg',
      title: 'สอนลงพื้นที่ราชบุรีตรวจสอบผลการดำเนินงานโรงงานน้ำตาลและเยี่ยมชมการบริหารจัดการไร่อ้อย',
      subTitle: '20 ชั่วโมงที่ผ่านมา',
    ),
    HomeNewsModelItem(
      newsImage: 'assets/images/landing/sample/plot4.jpg',
      title: 'เกษตรกรชาวไร่อ้อย ตรวจสอบสิทธิ์เงินช่วยเหลือ',
      subTitle: '22 ชั่วโมงที่ผ่านมา',
    ),
    HomeNewsModelItem(
      newsImage: 'assets/images/landing/sample/plot3.jpg',
      title: 'เกษตรกรชาวไร่อ้อย เตรียมจดทะเบียนรับสิทธิประโยชน์',
      subTitle: '24 ชั่วโมงที่ผ่านมา',
    ),
    HomeNewsModelItem(
      newsImage: 'assets/images/landing/sample/plot1.jpg',
      title: 'สอนลงพื้นที่ราชบุรีตรวจสอบผลการดำเนินงานโรงงานน้ำตาลและเยี่ยมชมการบริหารจัดการไร่อ้อย',
      subTitle: '20 ชั่วโมงที่ผ่านมา',
    ),
  ]);

  return list;
}
