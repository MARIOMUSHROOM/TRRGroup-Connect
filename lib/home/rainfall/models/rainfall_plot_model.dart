import '../../../base_class/models/ai_base_model.dart';

class RainfallPlotItem extends AiBasicItem {
  int plotNumber;
  double relativeHumidity; // ความชื้น
  int chanceOfRain; // โอกาสเกิดฝน
  double dewPoint; // จุดน้ำค้าง
  double rainfall;
  double rainfallLastYear;
  double rainfallCurrentYear;

  final String placeHolderPlotImage = 'assets/images/landing/background.png'; // default picture for plot image
  String plotImageUrl = '';

  RainfallPlotItem({
    /// get values from TRR API
    this.plotNumber,
    this.plotImageUrl,
    this.rainfallLastYear,
    this.rainfallCurrentYear,

    /// get valuse from another sources of API
    this.relativeHumidity,
    this.chanceOfRain,
    this.dewPoint,
    this.rainfall,
  });
}

class RainfallPlotList extends AiBasicList {
  @override
  AiBaseItem getNewObjItem() => RainfallPlotItem();

  List<RainfallPlotItem> get plotItems => super.items;

  @override
  List<AiBaseItem> getObjList() => <RainfallPlotItem>[];

  void addPlot(RainfallPlotItem plotItem) => plotItems.add(plotItem);
}

String getDummyPlotImage(int aCounter) {
  var modRes = aCounter % 8; // modulo by number picture if want to div use aCounter ~/ 8; return int
  switch (modRes) {
    case 0:
      return 'https://www.farmkaset.org/html5/upload/25630927201932-1R.jpg';
    case 1:
      return 'https://static.thairath.co.th/media/dFQROr7oWzulq5FZYjudsp80XO9WWVWWjfDu1t5damSSFlywwZcKmQcC9KdBukqA7Xi.webp';
    case 2:
      return 'https://cf.shopee.co.th/file/85cf140bb748b0bc81d5ce652237a709';
    case 3:
      return 'https://static.posttoday.com/media/content/2017/11/22/828B0C932A88438199886C10CBA87E65.jpg';
    case 4:
      return 'https://mpics.mgronline.com/pics/Images/564000004339301.JPEG';
    case 5:
      return 'https://www.matichon.co.th/wp-content/uploads/2017/03/%E0%B9%84%E0%B8%A3%E0%B9%88%E0%B8%AD%E0%B9%89%E0%B8%AD%E0%B8%A2-728x526.jpg';
    case 6:
      return 'https://www.77kaoded.com/wp-content/uploads/IMG_1845-4-1024x576.jpg';
    case 7:
      return 'https://www.prachachat.net/wp-content/uploads/2020/06/%E0%B8%AD%E0%B9%89%E0%B8%AD%E0%B8%A2-728x527-728x527.jpg';
    default:
      return 'https://www.farmkaset.org/html5/upload/25630927201932-1R.jpg';
  }
}

RainfallPlotList dummyPlotList() {
  var list = RainfallPlotList();
  for (var i = 1; i <= 30; i++) {
    list.addPlot(RainfallPlotItem(
      plotNumber: i,
      plotImageUrl: getDummyPlotImage(i),
      relativeHumidity: i + 50.0,
      chanceOfRain: i + 60,
      dewPoint: i + 16.0,
      rainfall: i * 0.1,
    ));
  }
  return list;
}

/*
https://www.farmkaset.org/html5/upload/25630927201932-1R.jpg
https://www.prachachat.net/wp-content/uploads/2020/06/%E0%B8%AD%E0%B9%89%E0%B8%AD%E0%B8%A2-728x527-728x527.jpg
https://cf.shopee.co.th/file/85cf140bb748b0bc81d5ce652237a709
https://static.posttoday.com/media/content/2017/11/22/828B0C932A88438199886C10CBA87E65.jpg
https://mpics.mgronline.com/pics/Images/564000004339301.JPEG
https://www.matichon.co.th/wp-content/uploads/2017/03/%E0%B9%84%E0%B8%A3%E0%B9%88%E0%B8%AD%E0%B9%89%E0%B8%AD%E0%B8%A2-728x526.jpg
https://www.77kaoded.com/wp-content/uploads/IMG_1845-4-1024x576.jpg
https://static.thairath.co.th/media/dFQROr7oWzulq5FZYjudsp80XO9WWVWWjfDu1t5damSSFlywwZcKmQcC9KdBukqA7Xi.webp
 */
