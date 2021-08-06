import 'package:ai_flutter/home/activity/model/local_model.dart';

// data for change keyword plant

final PlantHistory keyWordPlantHistoryData1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "15 ธ.ค. 2565",
  title: "กำจัด วัชพืช",
  content: keyWordcontent1,
);
List<String> keyWordcontent1 = [
  "อามารีน",
  "อัตรการใช้",
  "ปริมาณที่ใช้ฉีดพ่น",
  "ค่าใช้จ่ายสารเคมี 1,000 บาท",
  "ค่าจ้างเหมา 500 บาท",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final PlantHistory keyWordPlantHistoryData2 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "XXXX",
  content: keyWordcontent2,
);
List<String> keyWordcontent2 = [
  "อามารีน",
  "อัตรการใช้",
  "ปริมาณที่ใช้ฉีดพ่น",
  "ค่าใช้จ่ายสารเคมี 1,000 บาท",
  "ค่าจ้างเหมา 500 บาท",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final List<PlantHistory> keyWordListData = [
  keyWordPlantHistoryData1,
  keyWordPlantHistoryData2
];
