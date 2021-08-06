import 'package:ai_flutter/home/activity/model/local_model.dart';

//data for set plant

final PlantHistory dataPlantHistory1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "10 ธ.ค. 2563",
  title: "ไถ่บุกเบิก ครั้งที่ 1",
  content: content1,
);
List<String> content1 = [
  "ริปเปอร์ระเบิดดินดาน",
  "ค่าจ้างรถไถ 1,000 บาท",
  "ค่าจ้างแรงงาน 1,000 บาท",
  "ปริมาณที่ใช้เชื้อเพลิง 10 ลิตร",
  "ราคาเชื้อเพลิง 500 บาท"
];

final PlantHistory dataPlantHistory2 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "3 ธ.ค. 2563",
  title: "ไถ่พรวนครั้งที่ 1",
  content: content2,
);
List<String> content2 = [
  "จอบหมุน",
  "ค่าจ้างรถไถ 1,000 บาท",
  "ค่าจ้างแรงงาน 1,000 บาท",
  "ปริมาณที่ใช้เชื้อเพลิง 10 ลิตร",
  "ราคาเชื้อเพลิง 500 บาท"
];
final PlantHistory dataPlantHistory3 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "ไถ่พรวนครั้งที่ XX",
  content: content3,
);
List<String> content3 = [
  "จอบหมุน",
];

final List<PlantHistory> setPlantDataList = [
  dataPlantHistory1,
  dataPlantHistory2,
  dataPlantHistory3
];

//data for seed plant

final PlantHistory dataSeedPlantHistory1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "10 ธ.ค. 2563",
  title: "พันธุ์อ้อย อู่ทอง",
  content: contentSeed1,
);
List<String> contentSeed1 = [
  "ระยะห่างระหว่างร่อง 10 เมตร",
  "ปริมาณที่ใช้",
  "ค่าตัดท่อนพันธุ์ 100 บาท",
  "ราคาท่อนพันธุ์ 500 บาท",
  "ค่าจ้างรถชักร่อง 2,000 บาท",
  "ค่าปุ๋ยรองพื้น 2,000 บาท",
  "ค่าจ้างรถปลูกอ้อย 3,000 บาท",
  "ค่าจ้างแรงงาน 13,000 บาท",
  "ราคาเชื้อเพลิง 300 บาท",
];

final PlantHistory dataSeedPlantHistory2 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "3 ธ.ค. 2563",
  title: "XXXXX",
  content: contentSeed2,
);
List<String> contentSeed2 = [];
final PlantHistory dataSeedPlantHistory3 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "XXXX",
  content: contentSeed3,
);
List<String> contentSeed3 = [
  "XXXX",
];

final List<PlantHistory> seedPlantDataList = [
  dataSeedPlantHistory1,
  dataSeedPlantHistory2,
  dataSeedPlantHistory3
];

// data for water plant
final PlantHistory dataWaterPlantHistory1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "10 ธ.ค. 2563",
  title: "แหล่งน้ำ น้ำฝน",
  content: contentWater1,
);
List<String> contentWater1 = [
  "ระบบน้ำ หยด",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final PlantHistory dataWaterPlantHistory2 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "3 ธ.ค. 2563",
  title: "แหล่งน้ำ น้ำคลอง",
  content: contentWater2,
);
List<String> contentWater2 = [
  "ระบบน้ำ ราด",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final PlantHistory dataWaterPlantHistory3 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "XXXX",
  content: contentWater3,
);
List<String> contentWater3 = [
  "XXXX",
];

final List<PlantHistory> waterPlantDataList = [
  dataWaterPlantHistory1,
  dataWaterPlantHistory2,
  dataWaterPlantHistory3
];

// data for water spray plant
final PlantHistory dataWaterSprayPlantHistory1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "10 ธ.ค. 2563",
  title: "ฉีดน้ำหมักปุ๋ยยูเรียครั้งที่ 1",
  content: contentWaterSpray1,
);
List<String> contentWaterSpray1 = [
  "สูตร",
  "ปริมาณน้ำหมักปุ๋ยน้ำยูเรีย 3 ลิตร",
  "ปุ๋ยยูเรีย 40 กรัม",
  "น้ำ 15 ลิตร",
  "ค่าปุ๋ยยูเรียกระสอบละ 15 บาท",
  "ปริมาณส่วนผสม",
  "ราคาส่วนผสม",
  "ค่าจ้างรถฉีดพ่น 1,500 บาท",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final PlantHistory dataWaterSprayPlantHistory3 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "XXXX",
  content: contentWaterSpray3,
);
List<String> contentWaterSpray3 = [
  "XXXX",
];

final List<PlantHistory> waterSprayPlantDataList = [
  dataWaterSprayPlantHistory1,
  dataWaterSprayPlantHistory3
];

// data for chemical spray plant
final PlantHistory dataChemicalSprayPlantHistory1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "15 ธ.ค. 2565",
  title: "กำจัด วัชพืช",
  content: contentChemicalSpray1,
);
List<String> contentChemicalSpray1 = [
  "อามารีน",
  "อัตรการใช้",
  "ปริมาณที่ใช้ฉีดพ่น",
  "ค่าใช้จ่ายสารเคมี 1,000 บาท",
  "ค่าจ้างเหมา 500 บาท",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final PlantHistory dataChemicalSprayPlantHistory3 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "XXXX",
  content: contentChemicalSpray3,
);
List<String> contentChemicalSpray3 = [
  "อามารีน",
  "อัตรการใช้",
  "ปริมาณที่ใช้ฉีดพ่น",
  "ค่าใช้จ่ายสารเคมี 1,000 บาท",
  "ค่าจ้างเหมา 500 บาท",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final List<PlantHistory> chemicalSprayPlantDataList = [
  dataChemicalSprayPlantHistory1,
  dataChemicalSprayPlantHistory3
];

// data for change Manure plant
final PlantHistory dataManurePlantHistory1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "15 ธ.ค. 2565",
  title: "ใส่ปุ๋ย ปุ๋นคอมโพส",
  content: contentManure1,
);
List<String> contentManure1 = [
  "ใส่ปุ๋ยครั้งที่ 1",
  "สูตร",
  "ปริมาณที่ใช้",
  "ค่าปุ๋ย กระสอบละ 1,000 บาท",
  "ค่าแรงงาน 500 บาท",
  "ค่าเครื่องจักร 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final PlantHistory dataManurePlantHistory3 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "XXXX",
  content: contentManure3,
);
List<String> contentManure3 = [
  "ใส่ปุ๋ยครั้งที่ 1",
  "สูตร",
  "ปริมาณที่ใช้",
  "ค่าปุ๋ย กระสอบละ 1,000 บาท",
  "ค่าแรงงาน 500 บาท",
  "ค่าเครื่องจักร 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final List<PlantHistory> manureDataList = [
  dataManurePlantHistory1,
  dataManurePlantHistory3
];

// data for change Cut plant

final PlantHistory dataCutPlantHistory1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "15 ธ.ค. 2565",
  title: "ตัดอ้อย โดยรถตัดอ้อย",
  content: contentCut1,
);
List<String> contentCut1 = [
  "ปริมาณอ้อย 200 กรัม",
  "ไว้ใบอ้อย 50 %",
  "ค่าจ้างรถตัด 1,000 บาท",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final PlantHistory dataCutPlantHistory3 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "ตัดอ้อย โดยคนตัดอ้อย",
  content: contentCut3,
);
List<String> contentCut3 = [
  "ปริมาณอ้อย 200 กรัม",
  "ไว้ใบอ้อย 50 %",
  "ค่าจ้างรถตัด 1,000 บาท",
  "ค่าจ้างแรงงาน 2,000 บาท",
  "ราคาเชื้อเพลิง 500 บาท",
];

final List<PlantHistory> cutDataList = [
  dataCutPlantHistory1,
  dataCutPlantHistory3
];

// data for change ship plant

final PlantHistory shipPlantHistoryData1 = new PlantHistory(
  farmName: "แปลงที่ 1",
  time: "8.00 น.",
  date: "15 ธ.ค. 2565",
  title: "ขนส่งอ้อยครั้งที่ 1",
  content: shipcontent1,
);
List<String> shipcontent1 = [
  "จำนวนรถบรรทุก 2 คัน",
  "จำนวนรถบรรทุก 2 คัน",
  "จำนวนเงินค่าขนส่ง 2,000 บาท",
];

final PlantHistory shipPlantHistoryData2 = new PlantHistory(
  farmName: "แปลงที่ XX",
  time: "8.00 น.",
  date: "XX ธ.ค. 2563",
  title: "ขนส่งอ้อยครั้งที่ 2",
  content: shipcontent2,
);
List<String> shipcontent2 = [
  "จำนวนรถบรรทุก 2 คัน",
  "จำนวนรถบรรทุก 2 คัน",
  "จำนวนเงินค่าขนส่ง 2,000 บาท",
];

final List<PlantHistory> shipListData = [
  shipPlantHistoryData1,
  shipPlantHistoryData2
];

// // data test for activity process
// List<String> activityContent1 = ["อ้อยปลูกใหม่ 50 ไร่ ไถบุกเบิกครั้งที่ 1"];
// List<String> activityContent2 = ["อ้อยปลูกใหม่ 50 ไร่ ปลูกอ้อย พันธุ์อู่ทอง"];
// List<String> activityContent3 = [
//   "อ้อยตอ 10 ไร่",
//   "ฉีดน้ำหมักปุ๋ยยูเรีย ครั้งที่ 1"
// ];
// List<String> activityContent4 = ["อ้อยตอ 5 ไร่ ฉีดน้ำหมักปุ๋ยยูเรียครั้งที่ 1"];
// List<String> activityContent5 = ["อ้อยตอปลูกใหม่ 1 ไร่ ไถบุกเบิกครั้งที่ 1"];

// ActivityProcess activityProcess1 = new ActivityProcess(
//   title: "แปลงที่ 1",
//   content: activityContent1,
//   date: DateTime(2021),
// );
// ActivityProcess activityProcess2 = new ActivityProcess(
//   title: "แปลงที่ 1",
//   content: activityContent2,
//   date: DateTime(2021),
// );
// ActivityProcess activityProcess3 = new ActivityProcess(
//   title: "แปลงที่ 1",
//   content: activityContent3,
//   date: DateTime(2021),
// );
// ActivityProcess activityProcess4 = new ActivityProcess(
//   title: "แปลงที่ 2",
//   content: activityContent4,
//   date: DateTime(2021),
// );
// ActivityProcess activityProcess5 = new ActivityProcess(
//   title: "แปลงที่ 2",
//   content: activityContent5,
//   date: DateTime(2021),
// );

// List<ActivityProcess> activityProcessList = [
//   activityProcess1,
//   activityProcess2,
//   activityProcess3,
//   activityProcess4,
//   activityProcess5,
// ];
