import 'package:ai_flutter/notify/test/test_model.dart';

List<Notify> activityList = [activity1, activity2, activity3];
Notify activity1 = new Notify(
  content:
      "มีการเพิ่มกิจกรรมอ้อยปลูกใหม่ \"ไถ่บุกเบิกครั้งที่ 1\" ริปเปอร์ระเบิดดินดาน ในแปลงที่ 1",
  date: DateTime(2023, 12, 7),
);
Notify activity2 = new Notify(
  content:
      "มีการเพิ่มกิจกรรมประเภทอ้อยตอ \"ใส่ปุ๋ยคอมโพส\" ใส่ปุ๋ยครั้งที่ 1 ในแปลงที่ 4",
  date: DateTime(2021, 12, 15),
);
Notify activity3 = new Notify(
  content:
      "มีการเพิ่มกิจกรรมประเภทแปลงผสม \"ฉีดน้ำหมักปุ๋ยยูเรีย\" จำนวน 40 ไร่ ในแปลงที่ 15",
  date: DateTime(2021, 12, 15),
);

List<Notify> newpaperList = [newpaper1, newpaper2, newpaper3];
Notify newpaper1 = new Notify(
  content: "เกษตรกรชาวไร่อ้อยตรวจสอบสิทธุิ์เงินช่วยหลังประกัน...",
  date: DateTime(2023, 12, 7),
);
Notify newpaper2 = new Notify(
  content: "เกษตรกรชาวไร่อ้อยเตรียมจดทะเบียนรับสิทธิประโยชน์",
  date: DateTime(2021, 12, 15),
);
Notify newpaper3 = new Notify(
  content: "\"สุริยะ\" ฉีดหมื่นล้านช่วยชาวไร่อ้อย",
  date: DateTime(2021, 12, 15),
);
